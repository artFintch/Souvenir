//
//  UIButton+Style.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 30/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

extension UIButton {
    func applyMainStyle() {
        setBackgroundImage(UIImage(color: Colors.mainButtonBackgroundColor), for: .normal)
        setTitleColor(Colors.mainButtonFontColor, for: .normal)
        titleLabel?.font = Fonts.mainButtonFont
    }
}
