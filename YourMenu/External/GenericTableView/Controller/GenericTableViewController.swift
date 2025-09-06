//
//  GenericTableViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import UIKit

protocol GenericTableViewControllerDelegate: AnyObject {
    func didSelectItem(_ item: Any)
}

class GenericTableViewController<cell: BaseCell<M>, M>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    weak var selectionDelegate: GenericTableViewControllerDelegate?
    
    var subcategoryId: Int?
    
    internal var items: [M] = [] {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(cell.self, forCellReuseIdentifier: cell.description())
    }
    
    var customRowHeight: CGFloat = 40 {
        didSet {
            rowHeight = customRowHeight
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createData(items: [M]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell.description(), for: indexPath) as? cell {
            cell.config(item: items[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedItem = items[indexPath.row]
         selectionDelegate?.didSelectItem(selectedItem)
     }
}
