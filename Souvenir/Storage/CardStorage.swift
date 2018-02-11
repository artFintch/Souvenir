//
//  CardStorage.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 11/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import Stripe

// TODO: Implement hashable
class Card: NSObject, STPSourceProtocol {
    let stripeID: String
    let type: CardType
    let last4: String
    
    var icon: UIImage {
        switch type {
        case .visa:
            return #imageLiteral(resourceName: "visaIcon")
        case .masterCard:
            return #imageLiteral(resourceName: "masterCardIcon")
        }
    }
    
    var protectedNumber: String {
        var protectedNumber = ""
        let groupSize = 4
        for index in 0..<(groupSize * 3) {
            if index != 0 && index % groupSize == 0 {
                protectedNumber += " "
            }
            protectedNumber += "*"
        }
        return protectedNumber + " " + last4
    }
    
    init(stripeID: String, type: CardType, last4: String) {
        self.stripeID = stripeID
        self.type = type
        self.last4 = last4
    }
    
    init?(card: STPCard) {
        guard let type = CardType(brand: card.brand) else {
            return nil
        }
        self.type = type
        self.last4 = card.last4
        self.stripeID = card.stripeID
    }
}

class CardStorage: CardDataSource {
    var cards: [Card] = []
    var defaultCardIndex: Int?
    
    var selectedCard: Card? {
        guard let index = defaultCardIndex, index < cards.count else { return nil }
        return cards[index]
    }
    
    func addNewCard(_ card: Card) {
        guard !cards.contains(card) else { return }
        cards.append(card)
        
        if defaultCardIndex == nil {
            defaultCardIndex = cards.count - 1
        }
    }
}
