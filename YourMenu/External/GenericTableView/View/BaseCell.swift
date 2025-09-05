//
//  BaseCell.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import UIKit

class BaseCell<M>: UITableViewCell {
    
    var item: M?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(item: M) {}
}
