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
    var selectedCardIndex: Int? {
        get {
            return dataSource.defaultCardIndex
        }
        set {
            dataSource.defaultCardIndex = newValue
        }
    }
    
    var selectedCard: Card? {
        return dataSource.selectedCard
    }
    
    init(dataSource: CardDataSource) {
        self.dataSource = dataSource
    }
}
