//
//  CardPickerModel.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class CardPickerModel {
    let dataSource: CardDataSource
    
    var isFold = true
    var selectedCardIndex: Int?
    
    var selectedCard: CardConst? {
        guard let index = selectedCardIndex, dataSource.cards.count > index else { return nil }
        return dataSource.cards[index]
    }
    
    init(dataSource: CardDataSource) {
        self.dataSource = dataSource
        self.selectedCardIndex = dataSource.defaultCardIndex
    }
}
