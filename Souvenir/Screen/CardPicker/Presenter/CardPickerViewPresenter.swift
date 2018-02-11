//
//  CardPickerViewPresenter.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class CardPickerViewPresenter {
    let model: CardPickerModel
    let stripeManager: StripeManager
    weak var view: CardPickerView?
    
    var isFold: Bool {
        return model.isFold
    }
    
    var selectedCardIndex: Int? {
        guard let index = model.selectedCardIndex else { return nil }
        return index + 1
    }
    
    func update() {        
        view?.showLoadingIndicator()
        stripeManager.getCards { [weak self] response in
            guard let `self` = self else { return }
            
            self.view?.hideLoadingIndicator()
            switch response {
            case .success(let cards, let defaultSourceIndex):
                self.model.dataSource.cards = cards
                self.model.dataSource.defaultCardIndex = defaultSourceIndex
                self.prepareCells()
                self.view?.update()
            case .failure(let erorr):
                self.view?.showAlert(withError: erorr)
            }
        }
    }
    
    func handleRow(at index: IndexPath) {
        if model.isFold {
            if cardsCount == 0 {
                view?.addNewCard()
            } else {
                model.isFold = false
                prepareCells()
                
                var indices: [IndexPath] = []
                if var selectedIndex = model.selectedCardIndex {
                    indices.append(IndexPath(row: 0, section: 0))
                    selectedIndex += 1
                    
                    for index in 1..<selectedIndex {
                        indices.append(IndexPath(row: index, section: 0))
                    }
                    
                    for index in (selectedIndex + 1)..<cells.count {
                        indices.append(IndexPath(row: index, section: 0))
                    }
                } else {
                    for index in 1..<cells.count {
                        indices.append(IndexPath(row: index, section: 0))
                    }
                }
                
                view?.unfold()
                view?.insertRows(at: indices)
            }
        } else {
            if index.row == 0 {
                view?.addNewCard()
                return
            }
            
            var indices: [IndexPath] = []
            for index in 0..<index.row {
                indices.append(IndexPath(row: index, section: 0))
            }
            
            model.selectedCardIndex = index.row - 1
            
            for index in (index.row + 1)..<cells.count {
                indices.append(IndexPath(row: index, section: 0))
            }
            
            model.isFold = true
            prepareCells()
            
            view?.fold()
            view?.selectCell(at: index)
            view?.deleteRows(at: indices)
        }
    }
    
    private let addNewCardCellModel = AddNewCardCellModel(icon: #imageLiteral(resourceName: "plusIcon"), title: "ADD NEW CARD")
    private func prepareCells() {
        if isFold {
            if model.dataSource.cards.isEmpty || model.selectedCardIndex == nil {
                cells = [addNewCardCellModel]
            } else if let selectedCard = model.selectedCard {
                cells = [CardCellModel(icon: selectedCard.icon,
                                      cardNumber: selectedCard.protectedNumber)]
            }
        } else {
            var cellsModels: [CellModelInterface] = []
            cellsModels.append(addNewCardCellModel)
            cellsModels.append(contentsOf: model.dataSource.cards.map {
                CardCellModel(icon: $0.icon, cardNumber: $0.protectedNumber)
            })
            cells = cellsModels
        }
    }
    
    private(set) var cells: [CellModelInterface] = []
    var cardsCount: Int {
        return model.dataSource.cards.count
    }
    
    init(model: CardPickerModel, stripeManager: StripeManager) {
        self.model = model
        self.stripeManager = stripeManager
        prepareCells()
    }
}
