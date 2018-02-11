//
//  LoaderViewController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 11/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

protocol AnimatedLoading {
    func startAnimating()
    func stopAnimating()
}

protocol UIViewType {}
extension UIActivityIndicatorView: UIViewType, AnimatedLoading {}

class LoaderViewController: UIViewController {
    lazy var loader: UIViewType & AnimatedLoading = {
        return UIActivityIndicatorView(activityIndicatorStyle: .white)
    }()
    
    private lazy var loaderView: UIView = self.loader as! UIView
    private let showAnimationDuration: TimeInterval = 0.2
    private var hiddenViews: [UIView] = []
    
    // In current implementation ignoring x and width
    func beginLoad(in visibleRect: CGRect? = nil) {
        hideViews()
        showLoader(in: visibleRect)
    }
    
    func endLoad() {
        if !hideLoader() { return }
        showViews()
    }
    
    private func showLoader(in visibleRect: CGRect?) {
        view.addSubview(loaderView)
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        if let visibleRect = visibleRect {
            let yOffset = visibleRect.origin.y + (visibleRect.height - loaderView.bounds.height) / 2
            loaderView.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: yOffset).isActive = true
        } else {
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        [loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         loaderView.widthAnchor.constraint(equalToConstant: loaderView.bounds.width),
         loaderView.heightAnchor.constraint(equalToConstant: loaderView.bounds.height)]
            .forEach { $0.isActive = true }
        
        loaderView.isHidden = false
        loader.startAnimating()
    }
    
    @discardableResult private func hideLoader() -> Bool {
        loader.stopAnimating()
        if loaderView.superview == nil { return false }
        loaderView.removeFromSuperview()
        return true
    }
    
    private func hideViews() {
        hiddenViews = view.subviews.filter { !$0.isHidden }
        hiddenViews.forEach { $0.isHidden = true }
    }
    
    private func showViews() {
        let views = hiddenViews.filter { $0.isHidden }
        hiddenViews.removeAll()
        views.forEach {
            $0.alpha = 0.0
            $0.isHidden = false
        }
        
        UIView.animate(withDuration: showAnimationDuration) {
            views.forEach { $0.alpha = 1.0 }
        }
    }
}
