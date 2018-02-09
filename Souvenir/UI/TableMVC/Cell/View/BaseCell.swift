//
//  BaseCell.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 17/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell, CellInterface {
	func configure(withModel model: CellModelInterface, animated: Bool = false) {
		fatalError("\(self) need override method configure(withModel:)")
	}
}
