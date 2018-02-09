//
//  CellInterface.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 17/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import Foundation

protocol CellInterface {
	associatedtype CellModel
	func configure(withModel model: CellModel, animated: Bool)
}
