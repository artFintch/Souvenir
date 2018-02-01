//
//  MainViewController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var souvenirView: SouvenirView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var bottomButton: UIButton!
    
    private let presenter = MainViewPresenter()
    
    private lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                         action: #selector(swipe(_:)))
        gestureRecognizer.direction = .left
        return gestureRecognizer
    }()
    
    private lazy var rightSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                         action: #selector(swipe(_:)))
        gestureRecognizer.direction = .right
        return gestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        souvenirView.showSouvenir(presenter.currentSouvenir)
        pageControl.currentPage = 0
        
        view.addGestureRecognizer(leftSwipeGestureRecognizer)
        view.addGestureRecognizer(rightSwipeGestureRecognizer)
        pageControl.numberOfPages = presenter.souvenirCount
        pageControl.pageIndicatorTintColor = Colors.pageCircleColor
        pageControl.currentPageIndicatorTintColor = Colors.selectedPageCircleColor
        bottomButton.applyMainStyle()
    }
    
    @objc private func swipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
        case .left:
            presenter.showNextSouvenir()
        case .right:
            presenter.showPreviousSouvenir()
        default:
            break
        }
    }
    
    @IBAction private func bottomButtonAction() {
        
    }
}

extension MainViewController: MainView {
    func showSouvenir(_ souvenir: SouvenirType, atIndex index: Int) {
        souvenirView.showSouvenir(souvenir)
        pageControl.currentPage = index
        bottomButton.setTitle("SEND \(souvenir.description.uppercased())", for: .normal)
    }
    
    func showCreditCardPicker() {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showAlert(withError error: Error) {
        
    }
}
