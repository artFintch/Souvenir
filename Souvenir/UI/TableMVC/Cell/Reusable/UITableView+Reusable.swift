//
//  UITableView+Reusable.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 16/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

extension UITableView {
	final func register<T: UITableViewCell>(type: T.Type) where T: NibLoadable {
		register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
	}
	
	final func register<T: UITableViewCell>(type: T.Type) {
		register(type.self, forCellReuseIdentifier: type.reuseIdentifier)
	}
}
