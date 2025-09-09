//
//  CartCell.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 07.09.25.
//

import UIKit

final class CartCell: BaseCell<CartItem> {
    
    private var cartItem: CartItem?
    
    private let nameLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 16, weight: .medium)
           return label
       }()
       
       private let countLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 14, weight: .regular)
           label.textAlignment = .center
           return label
       }()

       private let subtotalPriceLabel: UILabel = {
           let label = UILabel()
           label.font = .systemFont(ofSize: 14, weight: .semibold)
           label.textColor = .systemOrange
           return label
       }()
    
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(subtotalPriceLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        subtotalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                   
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 20),

            subtotalPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            subtotalPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
               ])
    }
    
    override func config(item: CartItem) {
        nameLabel.text = item.product.name
        countLabel.text = "x\(item.quantity)"
        subtotalPriceLabel.text = "\(item.product.price * Double(item.quantity)) ₼"
    }
    
}
