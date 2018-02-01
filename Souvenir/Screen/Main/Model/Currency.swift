//
//  Currency.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 01/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

enum Currency {
    case euro
    
    var abbreviation: String {
        switch self {
        case .euro: return "EUR"
        }
    }
}
