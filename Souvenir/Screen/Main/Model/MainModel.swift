//
//  MainModel.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 01/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

class MainModel {
    let souvenirs: [SouvenirType] = [.small, .medium, .big]
    var selectedSouvenirIndex = 0
    var selectedSouvenir: SouvenirType {
        return souvenirs[selectedSouvenirIndex]
    }
    
    enum State {
        case selectSouvenir
        case selectCreditCard
    }
    var state: State = .selectSouvenir
}
