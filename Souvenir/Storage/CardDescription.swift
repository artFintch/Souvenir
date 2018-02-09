//
//  CardDescription.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

enum CardType: String {
    case visa
    case masterCard
}

protocol StandardCard {
    var type: CardType { get }
    var number: String { get }
    var holder: String { get }
    var expiry: String { get }
}

protocol CardDisplayable {
    var icon: UIImage { get }
    var protectedNumber: String { get }
}
