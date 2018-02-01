//
//  UIColor+Hex.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init?(hexRGB: String) {
        var string = hexRGB
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        
        if string.count != 6 {
            return nil
        }
        
        let filterSet = CharacterSet.init(charactersIn: "0123456789ABCDEF").inverted
        if string.uppercased().rangeOfCharacter(from: filterSet) != nil {
            return nil
        }
        
        var hex: UInt32 = 0
        Scanner(string: string).scanHexInt32(&hex)
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
