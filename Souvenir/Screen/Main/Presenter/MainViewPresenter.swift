//
//  MainViewPresenter.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class MainViewPresenter {
    private let model: MainModel
    let cardDataSource: CardDataSource
    let stripeManager: StripeManager
    weak var view: MainView?
        
    init(model: MainModel,
         cardDataSource: CardDataSource,
         stripeManager: StripeManager) {
        self.model = model
        self.cardDataSource = cardDataSource
        self.stripeManager = stripeManager
    }
    
    var currentSouvenir: SouvenirType {
        return model.selectedSouvenir
    }
    
    var souvenirCount: Int {
        return model.souvenirs.count
    }
    
    func showPreviousSouvenir() {
        if model.selectedSouvenirIndex != 0 {
            model.selectedSouvenirIndex -= 1
            view?.showSouvenir(model.selectedSouvenir, atIndex: model.selectedSouvenirIndex)
        }
    }
    
    func showNextSouvenir() {
        if model.selectedSouvenirIndex + 1 != model.souvenirs.count {
            model.selectedSouvenirIndex += 1
            view?.showSouvenir(model.selectedSouvenir, atIndex: model.selectedSouvenirIndex)
        }
    }
    
    func prepareServices() {
        view?.showLoadingIndicator()
        stripeManager.tryRetrieveCustomer { [weak self] error in
            guard let `self` = self else { return }
            
            // Silent handle error
            if let error = error {
                print(error)
            }
            
            self.getCards(completion: { [weak self] error in
                guard let `self` = self else { return }
                
                self.view?.hideLoadingIndicator()
                if let error = error {
                    self.view?.showAlert(withError: error)
                }
            })
        }
    }
    
    func touchBottomButton() {
        switch model.state {
        case .selectSouvenir:
            model.state = .selectCreditCard
            view?.disableSelectSouvenir()
            view?.showCreditCardPicker()
        case .selectCreditCard:
            guard let card = cardDataSource.selectedCard else {
                // TODO: Handle
                return
            }
            
            self.view?.showLoadingIndicator()
            let price = model.selectedSouvenir.price * 100
            stripeManager.pay(card: card, price: price, completion: { [weak self] error in
                guard let `self` = self else { return }
                
                self.view?.hideLoadingIndicator()
                if let error = error {
                    self.view?.showAlert(withError: error)
                } else {
                    self.view?.successPay()
                }
            })
        }
    }
    
    private func getCards(completion: @escaping (Error?) -> Void) {
        stripeManager.getCards(completion: { [weak self] response in
            switch response {
            case .success(let cards, let index):
                self?.cardDataSource.cards = cards
                self?.cardDataSource.defaultCardIndex = index
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
}
