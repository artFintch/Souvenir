//
//  FramePresentationController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class FramePresentationController: UIPresentationController {
    private var initialContainerViewFrame: CGRect?
    
    var contentInsets: UIEdgeInsets = .zero
    
    override var containerView: UIView? {
        guard let containerView = super.containerView else { return nil }
        
        if initialContainerViewFrame == nil {
            initialContainerViewFrame = containerView.frame
            containerView.clipsToBounds = true
        }
        
        if let initialFrame = initialContainerViewFrame {
            containerView.frame.origin.y = contentInsets.top
            containerView.frame.size.height = initialFrame.size.height - contentInsets.bottom
            
        }
        
        return containerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView
            else { return super.frameOfPresentedViewInContainerView }
        return containerView.bounds
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
