//
//  CardEditableStorage.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 07/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class CardEditableStorage: EditableCardDataSource {
    private(set) var cards: [CardConst] = []
    private(set) var defaultCardIndex: Int?
    
    func addNewCard(_ card: CardConst) {
        guard !cards.contains(card) else { return }
        cards.append(card)
        
        if defaultCardIndex == nil {
            defaultCardIndex = cards.count - 1
        }
    }
}
