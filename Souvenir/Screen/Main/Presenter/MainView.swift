//
//  MainView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 01/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

protocol MainView: class {
    func showSouvenir(_ souvenir: SouvenirType, atIndex index: Int)
    func disableSelectSouvenir()
    func showCreditCardPicker()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func successPay()
    func showAlert(withError error: Error)
}
