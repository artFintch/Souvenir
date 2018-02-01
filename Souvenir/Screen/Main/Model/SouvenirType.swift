//
//  SouvenirType.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 01/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

enum SouvenirType {
    case small
    case medium
    case big
    
    var price: Int {
        switch self {
        case .small: return 10
        case .medium: return 50
        case .big: return 100
        }
    }
    
    var currency: Currency {
        return .euro
    }
}

extension SouvenirType {
    var name: String {
        switch self {
        case .small: return "small"
        case .medium: return "medium"
        case .big: return "big"
        }
    }
    
    var description: String {
        return "\(name.capitalized) Souvenir"
    }
    
    var priceDescription: String {
        return "\(price) \(currency.abbreviation)"
    }
}
