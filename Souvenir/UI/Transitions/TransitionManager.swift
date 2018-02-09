//
//  TransitionManager.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    let presentAnimator: UIViewControllerAnimatedTransitioning?
    let dismissAnimator: UIViewControllerAnimatedTransitioning?
    
    init(presentAnimator: UIViewControllerAnimatedTransitioning?,
         dismissAnimator: UIViewControllerAnimatedTransitioning? = nil) {
        self.presentAnimator = presentAnimator
        self.dismissAnimator = dismissAnimator
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
}
