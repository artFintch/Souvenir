//
//  CardPickerViewController+UITableViewDataSource.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 10/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

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
