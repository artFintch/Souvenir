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
        guard let cardPicker = R.storyboard.cardPicker.instantiateInitialViewController() else {
            // TODO: Log
            return
        }
        
        if let currentSouvenir = presenter?.currentSouvenir {
            bottomButton.setTitle("PAY \(currentSouvenir.priceDescription)", for: .normal)
        }
        
        cardPicker.modalPresentationStyle = .custom
        cardPicker.transitioningDelegate = transitionManager
        cardPicker.presenter = {
            let dataSource = TestCardStorage()
            let model = CardPickerModel(dataSource: dataSource)
            let presenter = CardPickerViewPresenter(model: model)
            return presenter
        }()
        present(cardPicker, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showAlert(withError error: Error) {
        
    }
}
