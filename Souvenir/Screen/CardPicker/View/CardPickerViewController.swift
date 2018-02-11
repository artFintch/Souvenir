//
//  CardPickerViewController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class CardPickerViewController: LoaderViewController {
    @IBOutlet private(set) var dimBackground: UIView!
    @IBOutlet private(set) var tableView: UITableView!
    
    var presenter: CardPickerViewPresenter? {
        didSet {
            setupPresenter()
        }
    }
    
    private func setupPresenter() {
        guard let presenter = presenter, isViewLoaded else { return }
        presenter.view = self
        presenter.stripeManager.paymentContext?.hostViewController = self
    }
    
    let checkmarkIcon = UIImageView(image: #imageLiteral(resourceName: "checkmarkIcon"))
    let foldedPickerIcon = UIImageView(image: #imageLiteral(resourceName: "foldedPickerIcon"))
    private var needUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        
        dimBackground.alpha = 0.0
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 56.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
        tableView.register(type: AddNewCardCell.self)
        tableView.register(type: CardCell.self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        needUpdate = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needUpdate {
            presenter?.update()
            needUpdate = false
        }
    }
}
