//
//  CartViewController.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 07.09.25.
//

import UIKit

class CartViewController: UIViewController, CartViewModelDelegate {

    private lazy var viewModel: CartViewModelProtocol = {
        let vm = CartViewModelImpl()
        vm.delegate = self
        return vm
    }()
    
    private let tableView = CartTableView()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemOrange
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sebet"
        
        viewModel.loadCart()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func cartDidUpdate(_ viewModel: any CartViewModelProtocol) {
        tableView.reloadData()
        tableView.createData(items: viewModel.items)
        updateTotalPrice()
    }
    
    private func updateTotalPrice() {
        let totalPrice = viewModel.items.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
        totalPriceLabel.text = "Total: \(totalPrice) ₼"
    }
}
