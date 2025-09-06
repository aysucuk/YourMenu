//
//  ProductCell.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//


import UIKit

final class ProductCell: BaseCell<Product> {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()

    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemOrange
        return button
    }()
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(addToCartButton)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 120),
            productImageView.heightAnchor.constraint(equalToConstant: 120),

            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -50),


            priceLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            addToCartButton.widthAnchor.constraint(equalToConstant: 30)
           
        ])
    }
    
    override func config(item: Product) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price)"
        productImageView.image = UIImage(named: item.imageName)

    }
}
