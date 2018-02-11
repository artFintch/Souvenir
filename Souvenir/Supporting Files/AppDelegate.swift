//
//  AppDelegate.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let mainViewController = window?.rootViewController as? MainViewController else {
            fatalError()
        }
        
        let model = MainModel()
        let stripeStorage = StripeStorage()
        let stripeManager = StripeManager(stripeConfig: AppConfig.shared,
                                          customerInfo: stripeStorage)
        let cardStorage = CardStorage()
        mainViewController.presenter = MainViewPresenter(model: model,
                                                         cardDataSource: cardStorage,
                                                         stripeManager: stripeManager)
        
        return true
    }
}
