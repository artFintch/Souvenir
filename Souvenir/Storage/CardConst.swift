//
//  CardConst.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

struct CardConst: StandardCard {
    let type: CardType
    let number: String
    let holder: String
    let expiry: String
}

extension CardConst: CardDisplayable {
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
        let groupLimit = 4
        let groupSeparator = "  "
        let protectionCharacter = "*"
        
        var index = 0
        for character in number {
            if index != 0 && index != number.count && index % groupLimit == 0 {
                protectedNumber += groupSeparator
            }
            index += 1
            
            if index > number.count - groupLimit {
                protectedNumber += protectionCharacter
            } else {
                protectedNumber += String(character)
            }
        }
        return protectedNumber
    }
}

extension CardConst: Hashable {
    var hashValue: Int {
        return [type.rawValue, number, holder, expiry]
            .joined(separator: ",")
            .hashValue
    }
    
    static func ==(_ lhs: CardConst, _ rhs: CardConst) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
