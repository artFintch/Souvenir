//
//  MainViewController+MainView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 10/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

extension MainViewController: MainView {
    func showSouvenir(_ souvenir: SouvenirType, atIndex index: Int) {
        souvenirView.showSouvenir(souvenir)
        pageControl.currentPage = index
        bottomButton.setTitle("SEND \(souvenir.description.uppercased())", for: .normal)
    }
    
    func disableSelectSouvenir() {
        leftSwipeGestureRecognizer.isEnabled = false
        rightSwipeGestureRecognizer.isEnabled = false
    }
    
    func showCreditCardPicker() {
        guard let presenter = presenter,
            let cardPicker = R.storyboard.cardPicker.instantiateInitialViewController() else {
            // TODO: Log
            return
        }
        
        bottomButton.setTitle("PAY \(presenter.currentSouvenir.priceDescription)", for: .normal)
        
        cardPicker.modalPresentationStyle = .custom
        cardPicker.transitioningDelegate = transitionManager
        cardPicker.presenter = {
            let model = CardPickerModel(dataSource: presenter.cardDataSource)
            return CardPickerViewPresenter(model: model,
                                           stripeManager: presenter.stripeManager)
        }()
        present(cardPicker, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        presentedViewController?.view.isHidden = true
        beginLoad()
        backgroundImageView.isHidden = false
    }
    
    func hideLoadingIndicator() {
        presentedViewController?.view.isHidden = false
        endLoad()
    }
    
    func successPay() {
        let alertController = UIAlertController(title: "Success!",
                                                message: nil,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        let rootController = presentedViewController ?? self
        rootController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(withError error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        let rootController = presentedViewController ?? self
        rootController.present(alertController, animated: true, completion: nil)
    }
}
