//
//  CardPickerViewController+UITableViewDelegate.swift
//  Souvenir
//
//  Created by Vyacheslav Khorkov on 10/02/2018.
//  Copyright © 2018 Vyacheslav Khorkov. All rights reserved.
//

import UIKit

extension CardPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.handleRow(at: indexPath)
    }
}
