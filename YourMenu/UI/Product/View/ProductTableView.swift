//
//  ProductTableView.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 08.09.25.
//

import Foundation
import UIKit

class ProductTableView: GenericTableViewController<ProductCell, Product> {
    weak var cellDelegate: ProductCellDelegate?

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ProductCell
        cell.delegate = cellDelegate  // ProductCellDelegate override olunur
        return cell
    }
}
