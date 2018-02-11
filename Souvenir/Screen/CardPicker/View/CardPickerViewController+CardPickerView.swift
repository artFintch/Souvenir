//
//  CardPickerViewController+CardPickerView.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 10/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit
import Stripe

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
        presenter?.stripeManager.paymentContext?.presentPaymentMethodsViewController()
    }
    
    func update() {
        tableView.reloadData()
    }
    
    func showLoadingIndicator() {
        beginLoad()
        presentingViewController?.view.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator() {
        endLoad()
        presentingViewController?.view.isUserInteractionEnabled = true
    }
    
    func showAlert(withError error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
}
