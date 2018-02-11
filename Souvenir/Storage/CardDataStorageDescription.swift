//
//  CardDataStorageDescription.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

protocol CardDataSource: class {
    var cards: [Card] { get set }
    var defaultCardIndex: Int? { get set }
    var selectedCard: Card? { get }
}
