//
//  BaseCellModel.swift
//  TableMVC
//
//  Created by Vyacheslav Khorkov on 17/07/2017.
//  Copyright © 2017 Vyacheslav Khorkov. All rights reserved.
//

import CoreGraphics

class BaseCellModel: HeightConfigurable {
	var height: CGFloat?
	
	init(height: CGFloat? = nil) {
		self.height = height
	}
}
