//
//  AppConfig.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 11/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

protocol StripeConfig {
    var stripePublishableKey: String { get }
    var stripeBackendBaseURL: String { get }
}

class AppConfig: StripeConfig {
    static let shared = AppConfig()
    private init() {}
    
    let stripeBackendBaseURL = "https://souvenir-ios.herokuapp.com/"
}
