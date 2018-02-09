//
//  SlideTransitionAnimator.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class SlideTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionType {
        case presenting
        case dismissing
    }
    
    let transitionType: TransitionType
    let duration: TimeInterval
    
    init(transitionType: TransitionType, duration: TimeInterval = 0.3) {
        self.transitionType = transitionType
        self.duration = duration
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let to = transitionContext.viewController(forKey: .to)?.view else { return }
        
        let finishFrame: CGRect
        switch transitionType {
        case .presenting:
            let container = transitionContext.containerView
            container.addSubview(to)
            
            finishFrame = to.frame
            to.frame.origin.y = to.frame.height
        case .dismissing:
            // TODO: Implement dismiss
            finishFrame = .zero
            break
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        guard let `self` = self else { return }
                        
                        switch self.transitionType {
                        case .presenting:
                            to.frame = finishFrame
                        case .dismissing:
                            // TODO: Implement dismiss
                            break
                        }
            }, completion: { finished in
                transitionContext.completeTransition(finished)
        })
    }
}
