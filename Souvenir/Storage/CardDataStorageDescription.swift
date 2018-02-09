//
//  CardDataStorageDescription.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

protocol CardDataSource {
    var cards: [CardConst] { get }
    var defaultCardIndex: Int? { get }
}

protocol EditableCardDataSource: CardDataSource {
    func addNewCard(_ card: CardConst)
}
