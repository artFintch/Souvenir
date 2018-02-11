//
//  MainViewController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 29/01/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class MainViewController: LoaderViewController {
    @IBOutlet private(set) weak var backgroundImageView: UIImageView!
    @IBOutlet private(set) weak var souvenirView: SouvenirView!
    @IBOutlet private(set) weak var pageControl: UIPageControl!
    @IBOutlet private(set) weak var bottomButton: UIButton!
    
    var presenter: MainViewPresenter? {
        didSet {
            setupPresenter()
        }
    }
    
    private(set) lazy var transitionManager = CustomFrameTransitionManager(
        presentAnimator: SlideTransitionAnimator(transitionType: .presenting),
        dismissAnimator: SlideTransitionAnimator(transitionType: .dismissing),
        contentInsets: .init(top: 0.0,
                             left: 0.0,
                             bottom: self.bottomButton.bounds.size.height,
                             right: 0.0)
    )
    
    private(set) lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                         action: #selector(swipe(_:)))
        gestureRecognizer.direction = .left
        return gestureRecognizer
    }()
    
    private(set) lazy var rightSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self,
                                                         action: #selector(swipe(_:)))
        gestureRecognizer.direction = .right
        return gestureRecognizer
    }()
    
    private func setupPresenter() {
        guard let presenter = presenter, isViewLoaded else { return }
        presenter.view = self
        souvenirView.showSouvenir(presenter.currentSouvenir)
        pageControl.numberOfPages = presenter.souvenirCount
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        
        view.addGestureRecognizer(leftSwipeGestureRecognizer)
        view.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        pageControl.pageIndicatorTintColor = Colors.pageCircleColor
        pageControl.currentPageIndicatorTintColor = Colors.selectedPageCircleColor
        
        bottomButton.applyMainStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.prepareServices()
    }
    
    @objc private func swipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
        case .left:
            presenter?.showNextSouvenir()
        case .right:
            presenter?.showPreviousSouvenir()
        default:
            break
        }
    }
    
    @IBAction private func bottomButtonAction() {
        presenter?.touchBottomButton()
    }
}
