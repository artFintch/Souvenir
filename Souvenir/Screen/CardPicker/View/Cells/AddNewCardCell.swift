//
//  AddNewCardCell.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class AddNewCardCellModel: BaseCellModel, DescribeReusable {
    let reuseIdentifier = AddNewCardCell.reuseIdentifier
    
    let icon: UIImage?
    let title: String?
    
    init(icon: UIImage? = nil,
         title: String? = nil,
         height: CGFloat? = nil) {
        self.icon = icon
        self.title = title
        super.init(height: height)
    }
}

class AddNewCardCell: AnyCell, NibLoadable {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func configure(withModel model: CellModelInterface, animated: Bool) {
        guard let model = model as? AddNewCardCellModel else { return }
        iconImageView.image = model.icon
        titleLabel.text = model.title
    }
}
