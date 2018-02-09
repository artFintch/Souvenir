//
//  CardPickerViewController.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 08/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

class CardPickerViewController: BaseViewController {
    @IBOutlet private var dimBackground: UIView!
    @IBOutlet private var tableView: UITableView!
    
    var presenter: CardPickerViewPresenter? {
        didSet {
            setupPresenter()
        }
    }
    
    private func setupPresenter() {
        guard let presenter = presenter, isViewLoaded else { return }
        presenter.view = self
    }
    
    private let checkmarkIcon = UIImageView(image: #imageLiteral(resourceName: "checkmarkIcon"))
    private let foldedPickerIcon = UIImageView(image: #imageLiteral(resourceName: "foldedPickerIcon"))
    
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
}

extension CardPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            fatalError()
        }
        
        let model = presenter.cells[indexPath.row]
        let reuseIdentifier = model.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BaseCell
        cell?.configure(withModel: model)
        
        if presenter.isFold && presenter.cardsCount != 0 && indexPath.row == 0 {
            cell?.accessoryView = foldedPickerIcon
        } else if !presenter.isFold && indexPath.row == presenter.selectedCardIndex {
            cell?.accessoryView = checkmarkIcon
        } else {
            cell?.accessoryView = nil
        }
        
        cell?.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
        
        return cell!
    }
}

extension CardPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.handleRow(at: indexPath)
    }
}

extension CardPickerViewController: CardPickerView {
    func fold() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.dimBackground.alpha = 0.0
        }
    }
    
    func unfold() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.dimBackground.alpha = 1.0
        }
        
        for cell in tableView.visibleCells {
            if cell.accessoryView != nil {
                cell.accessoryView = checkmarkIcon
            }
        }
    }
    
    func selectCell(at index: IndexPath) {
        for cell in tableView.visibleCells {
            cell.accessoryView = nil
        }
        
        if tableView.visibleCells.count > index.row {
            tableView.visibleCells[index.row].accessoryView = checkmarkIcon
        }
    }
    
    func insertRows(at indexes: [IndexPath]) {
        tableView.insertRows(at: indexes, with: .top)
    }
    
    func deleteRows(at indexes: [IndexPath]) {
        CATransaction.begin()
        tableView.beginUpdates()
        CATransaction.setCompletionBlock {
            self.tableView.reloadData()
        }
        tableView.deleteRows(at: indexes, with: .top)
        tableView.endUpdates()
        CATransaction.commit()
    }
    
    func addNewCard() {
        
    }
}
