//
//  ViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//


import UIKit

class ProductViewController: UIViewController, AddProductViewControllerDelegate, CartButtonDelegate {
    
    private let tableView = ProductTableView()
    private let cartButton = CartButton()
    private let showCartButton: Bool
    
    private lazy var viewModel: ProductViewModelProtocol = {
        let vm = ProductViewModelImpl()
        vm.delegate = self
        return vm
    }()
    
    var subcategoryId: Int?
    weak var productDelegate: ProductCellDelegate?
    
    init(showCartButton: Bool = true) {
        self.showCartButton = showCartButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.cellDelegate = self
        cartButton.delegate = self
        
        viewModel.loadProducts(subcategoryId: subcategoryId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewProduct)
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(cartButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cartButton.widthAnchor.constraint(equalToConstant: 60),
            cartButton.heightAnchor.constraint(equalToConstant: 60),
            cartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func cartButtonDidTap(_ cartButton: CartButton) {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc private func addNewProduct() {
        guard let subcategoryId = self.subcategoryId else { return }
        let addVC = AddProductViewController()
        addVC.subcategoryId = subcategoryId
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func addProductViewController(_ controller: AddProductViewController, didSave product: Product) {
        guard let subId = self.subcategoryId else { return }
        viewModel.addProduct(product, to: subId)
    }
}

extension ProductViewController: ProductCellDelegate {
    func productCellDidTapAddToCart(_ cell: ProductCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = viewModel.products[indexPath.row]
        viewModel.addToCart(product)
    }
}

extension ProductViewController: ProductViewModelDelegate {
    func productViewModel(_ viewModel: ProductViewModelProtocol, didUpdateProducts products: [Product]) {
        tableView.createData(items: products)
    }
    
    func productViewModel(_ viewModel: ProductViewModelProtocol, didUpdateCart count: Int) {
        guard showCartButton else {
            cartButton.isHidden = true
            return
        }
        cartButton.updateBadge(count)
    }
}
