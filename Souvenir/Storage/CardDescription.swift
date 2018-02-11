//
//  CardDescription.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit
import Stripe

enum CardType: String {
    case visa
    case masterCard
    
    init?(brand: STPCardBrand?) {
        switch brand {
        case .visa?:
            self = .visa
        case .masterCard?:
            self = .masterCard
        default:
            return nil
        }
    }
}
