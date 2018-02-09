//
//  MainViewPresenter.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class MainViewPresenter {
    var model: MainModel
    weak var view: MainView?
    
    init(model: MainModel) {
        self.model = model
    }
    
    // Stripe service
    
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
    
    func touchBottomButton() {
        switch model.state {
        case .selectSouvenir:
            model.state = .selectCreditCard
            view?.disableSelectSouvenir()
            view?.showCreditCardPicker()
        case .selectCreditCard:
            break
        }
    }
}
