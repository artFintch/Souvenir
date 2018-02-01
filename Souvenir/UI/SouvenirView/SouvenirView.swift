//
//  SouvenirView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 30/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

@IBDesignable
class SouvenirView: BaseView {
    @IBOutlet private weak var bottomStarImageView: NSLayoutConstraint!
    
    @IBOutlet private weak var heightShineStarImageView: NSLayoutConstraint!
    @IBOutlet private weak var shineStarImageView: UIImageView!
    
    @IBOutlet private var shineStarsImageViews: [UIImageView]!
    @IBOutlet private var verticalAlignShineStarsImageViews: [NSLayoutConstraint]!
    @IBOutlet private var horizontalAlignShineStarsImageViews: [NSLayoutConstraint]!
    
    @IBOutlet private weak var shineCircleImageView: UIImageView!
    
    @IBOutlet private weak var heightShineCircleImageView: NSLayoutConstraint!
    @IBOutlet private weak var bottomShineCircleImageView: NSLayoutConstraint!
    @IBOutlet private weak var shineTopImageView: UIImageView!
    
    @IBOutlet private weak var envelopeImageView: UIImageView!
    @IBOutlet private weak var heightEnvelopeImageView: NSLayoutConstraint!
    
    @IBOutlet private weak var subtitleLabel: EdgeInsetLabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        subviews.first?.subviews.forEach { $0.alpha = 0.0 }
    }
    
    func showSouvenir(_ souvenir: SouvenirType) {
        envelopeImageView.alpha = 1.0
        subtitleLabel.alpha = 1.0
        priceLabel.alpha = 1.0
        
        subtitleLabel.text = souvenir.description
        priceLabel.text = souvenir.priceDescription
        layoutIfNeeded()
        
        switch souvenir {
        case .small:
            bottomStarImageView.constant = 16.0
            heightEnvelopeImageView.constant = 72.0
            heightShineCircleImageView.constant = 39.0
            if shineStarImageView.transform.isIdentity {
                shineStarImageView.transform = CGAffineTransform.identity.rotated(by: -0.3)
            }
        case .medium:
            bottomStarImageView.constant = 57.0
            heightEnvelopeImageView.constant = 106.0
            heightShineCircleImageView.constant = 58.0
            bottomShineCircleImageView.constant = 2.0
            heightShineStarImageView.constant = 36.0
        case .big:
            bottomStarImageView.constant = 39.0
            heightEnvelopeImageView.constant = 158.0
            bottomShineCircleImageView.constant = 60.0
            heightShineStarImageView.constant = 50.0
            shineStarsImageViews[0].transform = CGAffineTransform.identity.rotated(by: -0.5)
            shineStarsImageViews[1].transform = CGAffineTransform.identity.rotated(by: 0.1)
            shineStarsImageViews[2].transform = CGAffineTransform.identity.rotated(by: 0.4)
            shineStarsImageViews[3].transform = CGAffineTransform.identity.rotated(by: 0.1)
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let `self` = self else { return }
            
            switch souvenir {
            case .small:
                self.shineStarImageView.alpha = 0.0
                self.shineCircleImageView.alpha = 1.0
                self.shineTopImageView.alpha = 1.0
                self.shineStarImageView.transform = CGAffineTransform.identity.rotated(by: -0.3)
            case .medium:
                self.shineStarImageView.alpha = 1.0
                self.shineCircleImageView.alpha = 1.0
                self.shineTopImageView.alpha = 0.0
                self.shineStarsImageViews.forEach { $0.alpha = 0.0 }
                self.verticalAlignShineStarsImageViews.forEach { $0.constant = 0.0 }
                self.horizontalAlignShineStarsImageViews.forEach { $0.constant = 0.0 }
                self.shineStarImageView.transform = CGAffineTransform.identity.rotated(by: 0.3)
            case .big:
                self.shineStarImageView.alpha = 1.0
                self.shineCircleImageView.alpha = 0.0
                self.shineTopImageView.alpha = 0.0
                self.shineStarsImageViews.forEach { $0.alpha = 1.0 }
                self.horizontalAlignShineStarsImageViews[0].constant = -90.0
                self.horizontalAlignShineStarsImageViews[1].constant = -45.0
                self.horizontalAlignShineStarsImageViews[2].constant = 45.0
                self.horizontalAlignShineStarsImageViews[3].constant = 90.0
                self.verticalAlignShineStarsImageViews[0].constant = -112.0
                self.verticalAlignShineStarsImageViews[1].constant = -132.0
                self.verticalAlignShineStarsImageViews[2].constant = -132.0
                self.verticalAlignShineStarsImageViews[3].constant = -112.0
                self.shineStarImageView.transform = CGAffineTransform.identity.rotated(by: 0.6)
            }
            
            self.layoutIfNeeded()
        }
    }
}
