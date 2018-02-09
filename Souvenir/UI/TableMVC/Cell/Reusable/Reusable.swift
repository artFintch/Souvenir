//
//  Reusable.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 16/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

protocol Reusable: class {
	static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
