//
//  CustomFrameTransitionManager.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class CustomFrameTransitionManager: TransitionManager {
    private let contentInsets: UIEdgeInsets
    
    init(presentAnimator: UIViewControllerAnimatedTransitioning?,
         dismissAnimator: UIViewControllerAnimatedTransitioning? = nil,
         contentInsets: UIEdgeInsets = .zero) {
        self.contentInsets = contentInsets
        super.init(presentAnimator: presentAnimator, dismissAnimator: dismissAnimator)
    }
   
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?, source: UIViewController)
        -> UIPresentationController? {
        let presentationController = FramePresentationController(presentedViewController: presented,
                                                                 presenting: presenting)
        presentationController.contentInsets = contentInsets
        return presentationController
    }
}
