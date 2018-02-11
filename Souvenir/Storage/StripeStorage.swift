//
//  StripeStorage.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 11/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import Locksmith

class StripeStorage: CustomerInfo {
    private let defaultAccount = "Test"
    private let customerIdKey = "customer_id"
    
    var customerId: String? {
        get {
            let data = Locksmith.loadDataForUserAccount(userAccount: defaultAccount)
            return data?[customerIdKey] as? String
        }
        set {
            do {
                if let newValue = newValue {
                    try Locksmith.saveData(data: [customerIdKey: newValue],
                                           forUserAccount: defaultAccount)
                } else {
                    try Locksmith.deleteDataForUserAccount(userAccount: defaultAccount)
                }
            } catch {
                //print(error)
            }
        }
    }
}
