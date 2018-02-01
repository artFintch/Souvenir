//
//  BaseView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 30/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let views = ["v": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v]-0-|",
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]-0-|",
                                                      metrics: nil,
                                                      views: views))
    }
    
    private func loadViewFromNib() -> UIView? {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName,
                        bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self)[0] as? UIView else { return nil }
        
        return view
    }
}
