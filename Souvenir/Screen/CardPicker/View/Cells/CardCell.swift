//
//  CreditCardCell.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 09/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class CardCellModel: BaseCellModel, DescribeReusable {
    let reuseIdentifier = CardCell.reuseIdentifier
    
    let icon: UIImage?
    let cardNumber: String?
    
    init(icon: UIImage? = nil,
        cardNumber: String? = nil,
        height: CGFloat? = nil) {
        self.icon = icon
        self.cardNumber = cardNumber
        super.init(height: height)
    }
}

class CardCell: AnyCell, NibLoadable {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    
    override func configure(withModel model: CellModelInterface, animated: Bool) {
        guard let model = model as? CardCellModel else { return }
        iconImageView.image = model.icon
        cardNumberLabel.text = model.cardNumber
    }
}
