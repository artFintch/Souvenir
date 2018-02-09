//
//  TestCardStorage.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class TestCardStorage: CardEditableStorage {
    override init() {
        super.init()
        
        addNewCard(CardConst(type: .visa,
                             number: "1234567891234567",
                             holder: "IVAN IVANOV",
                             expiry: "10/19"))
        addNewCard(CardConst(type: .masterCard,
                             number: "9324312321439555",
                             holder: "PETR PETROV",
                             expiry: "10/20"))
    }
}
