//
//  CardPickerView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

protocol CardPickerView: class {
    func fold()
    func unfold()
    func selectCell(at index: IndexPath)
    func insertRows(at indexes: [IndexPath])
    func deleteRows(at indexes: [IndexPath])
    func addNewCard()
    func update()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlert(withError error: Error)
}
