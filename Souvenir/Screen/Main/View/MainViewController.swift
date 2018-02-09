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
    
    var presenter: MainViewPresenter? {
        didSet {
            setupPresenter()
        }
    }
    
    private lazy var transitionManager = CustomFrameTransitionManager(
        presentAnimator: SlideTransitionAnimator(transitionType: .presenting),
        dismissAnimator: SlideTransitionAnimator(transitionType: .dismissing),
        contentInsets: .init(top: 0.0,
                             left: 0.0,
                             bottom: self.bottomButton.bounds.size.height,
                             right: 0.0)
    )
    
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
    
    private func setupPresenter() {
        guard let presenter = presenter, isViewLoaded else { return }
        presenter.view = self
        souvenirView.showSouvenir(presenter.currentSouvenir)
        pageControl.numberOfPages = presenter.souvenirCount
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

extension MainViewController: MainView {
    func showSouvenir(_ souvenir: SouvenirType, atIndex index: Int) {
        souvenirView.showSouvenir(souvenir)
        pageControl.currentPage = index
        bottomButton.setTitle("SEND \(souvenir.description.uppercased())", for: .normal)
    }
    
    func disableSelectSouvenir() {
        leftSwipeGestureRecognizer.isEnabled = false
        rightSwipeGestureRecognizer.isEnabled = false
    }
    
    func showCreditCardPicker() {
        guard let cardPicker = R.storyboard.cardPicker.instantiateInitialViewController() else {
            // TODO: Log
            return
        }
        
        if let currentSouvenir = presenter?.currentSouvenir {
            bottomButton.setTitle("PAY \(currentSouvenir.priceDescription)", for: .normal)
        }
        
        cardPicker.modalPresentationStyle = .custom
        cardPicker.transitioningDelegate = transitionManager
        cardPicker.presenter = {
            let dataSource = TestCardStorage()
            let model = CardPickerModel(dataSource: dataSource)
            let presenter = CardPickerViewPresenter(model: model)
            return presenter
        }()
        present(cardPicker, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func showAlert(withError error: Error) {
        
    }
}
