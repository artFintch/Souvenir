//
//  NibLoadable.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 16/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
	static var nib: UINib { get }
}

extension NibLoadable {
	static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
	}
}

extension NibLoadable where Self: UIView {
	static func loadFromNib() -> Self {
		guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
			fatalError("The nib \(nib) expected its root view to be of type \(self)")
		}
		return view
	}
}
