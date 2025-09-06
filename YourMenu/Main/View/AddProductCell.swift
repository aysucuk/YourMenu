//
//  AddProductCell.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 06.09.25.
//

import UIKit

final class AddProductCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Ad"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let descriptionField: UITextField = {
        let field = UITextField()
        field.placeholder = "Təsvir"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let priceField: UITextField = {
        let field = UITextField()
        field.placeholder = "Qiymət"
        field.keyboardType = .decimalPad
        field.borderStyle = .roundedRect
        return field
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, descriptionField, priceField])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemGroupedBackground
        
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
    }
    
    var nameText: String? { nameField.text }
    var descriptionText: String? { descriptionField.text }
    var priceText: String? { priceField.text }
}
