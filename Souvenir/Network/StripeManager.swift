//
//  StripeManager.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 10/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

protocol CustomerInfo: class {
    var customerId: String? { get set }
}

class StripeManager: NSObject {
    private enum Endpoint: String {
        case customers
        case ephemeral_keys
        case charge
        
        func url(withBaseURL baseURL: URL) -> URL {
            return baseURL.appendingPathComponent(self.rawValue)
        }
    }
    
    private let publishableKey: String
    private let backendBaseURL: String
    private let customerInfo: CustomerInfo
    private var baseURL: URL {
        guard let url = URL(string: backendBaseURL) else {
            fatalError()
        }
        return url
    }
    private(set) var customerContext: STPCustomerContext?
    private(set) var paymentContext: STPPaymentContext?
    private var payCompletion: ((Error?) -> Void)?
    private var payCardId: String?
    
    init(stripeConfig: StripeConfig, customerInfo: CustomerInfo) {
        self.publishableKey = stripeConfig.stripePublishableKey
        self.backendBaseURL = stripeConfig.stripeBackendBaseURL
        self.customerInfo = customerInfo
        
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = publishableKey
        //config.canDeletePaymentMethods = false
    }
    
    private func prepareContextIfNeeded() {
        guard self.customerContext == nil || self.paymentContext == nil else { return }
        let customerContext = STPCustomerContext(keyProvider: self)
        self.customerContext = customerContext
        paymentContext = STPPaymentContext(customerContext: customerContext)
        paymentContext?.delegate = self
    }
    
    func tryRetrieveCustomer(completion: @escaping (Error?) -> Void) {
        guard let customerId = customerInfo.customerId else {
            completion(nil)
            return
        }
        
        let url = Endpoint.customers.url(withBaseURL: baseURL)
        Alamofire.request(url, method: .get, parameters:
            ["customer_id": customerId])
            .validate(statusCode: 200..<300)
            .responseJSON { [weak self] responseJSON in
                self?.prepareContextIfNeeded()
                switch responseJSON.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    // TODO: For custom UI
    /*func addCard(source: STPSourceProtocol, completion: @escaping (Error?) -> Void) {
        prepareContextIfNeeded()
        customerContext?.attachSource(toCustomer: source, completion: { error in
            if let error = error {
                print(error)
            }
            completion(error)
        })
    }*/
        
    enum GetCardsResponse {
        case success([Card], defaultSourceIndex: Int?)
        case failure(Error)
    }
    func getCards(completion: @escaping (GetCardsResponse) -> Void) {
        prepareContextIfNeeded()
        customerContext?.retrieveCustomer({ [weak self] customer, error in
            if let error = error {
                print(error)
                completion(.failure(error))
            }
            
            if let customer = customer {
                self?.customerInfo.customerId = customer.stripeID
                let cards = customer.sources
                    .flatMap { $0 as? STPCard }
                    .flatMap { Card(card: $0) }
                let defaultSourceIndex = customer.sources
                    .index(where: { $0.stripeID == customer.defaultSource?.stripeID })
                completion(.success(cards, defaultSourceIndex: defaultSourceIndex))
            } else {
                // Handle this case
                fatalError()
            }
        })
    }
    
    func pay(card: STPSourceProtocol, price: Int, completion: @escaping (Error?) -> Void) {
        payCardId = card.stripeID
        payCompletion = completion
        paymentContext?.paymentAmount = price
        paymentContext?.requestPayment()
    }
    
    private func charge(_ result: STPPaymentResult,
                        amount: Int,
                        completion: @escaping STPErrorBlock) {
        let url = Endpoint.charge.url(withBaseURL: baseURL)
        Alamofire.request(url, method: .post, parameters:
            ["source": payCardId ?? result.source.stripeID, "amount": amount])
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    print(response.result.debugDescription)
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
}

extension StripeManager: STPPaymentContextDelegate {
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didCreatePaymentResult paymentResult: STPPaymentResult,
                        completion: @escaping STPErrorBlock) {
        charge(paymentResult, amount: paymentContext.paymentAmount, completion: completion)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext,
                        didFinishWith status: STPPaymentStatus,
                        error: Error?) {
        switch status {
        case .error:
            payCompletion?(error)
        case .success:
            payCompletion?(nil)
        case .userCancellation:
            return
        }
        payCompletion = nil
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {}
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        payCompletion?(error)
        payCompletion = nil
    }
}

extension StripeManager: STPEphemeralKeyProvider {
    func createCustomerKey(withAPIVersion apiVersion: String,
                           completion: @escaping STPJSONResponseCompletionBlock) {
        let url = Endpoint.ephemeral_keys.url(withBaseURL: baseURL)
        Alamofire.request(url, method: .post, parameters:
            ["api_version": apiVersion])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
