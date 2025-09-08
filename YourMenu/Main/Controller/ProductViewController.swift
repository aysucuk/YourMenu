//
//  ViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//


import UIKit

class ProductViewController: UIViewController, AddProductViewControllerDelegate, CartButtonDelegate {

    internal var tableView: ProductTableView = {
       let view = ProductTableView()
        return view
    }()
    
    weak var productDelegate: ProductCellDelegate?
    
    private var products: [Product]
    var subcategoryId: Int?
    private let cartButton = CartButton()
    internal let showCartButton: Bool

    init(products: [Product],
         title: String,
         showCartButton: Bool = true) {
        self.products = products
        self.showCartButton = showCartButton
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartButton.delegate = self
        CartManager.shared.delegate = self
        tableView.cellDelegate = self
        
        setupUI()
        setupData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewProduct)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let subId = self.subcategoryId {
            let updatedProducts = MenuManager.shared.getProductsForSubcategory(subcategoryId: subId)
            reloadData(updatedProducts)
        } else {
            reloadData(products)
        }
        updateCartBadge()
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
    
    
    
    private func setupData() {
        tableView.createData(items: products)
    }
    
    func reloadData(_ products: [Product]) {
            self.products = products
            tableView.reloadData()
        }
    
    func cartButtonDidTap(_ cartButton: CartButton) {
        openCart()
    }

    
    @objc private func addNewProduct() {
        guard let subcategoryId = self.subcategoryId else { return }
        
        let addVC = AddProductViewController()
        addVC.subcategoryId = subcategoryId
        addVC.delegate = self
        
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc private func openCart() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc private func updateCartBadge() {
        guard showCartButton else {
            cartButton.isHidden = true
            return
        }
        let count = CartManager.shared.items.reduce(0) { $0 + $1.quantity }
        cartButton.updateBadge(count)
    }
    
    func addProductViewController(_ controller: AddProductViewController, didSave product: Product) {
        guard let subId = self.subcategoryId else { return }
        MenuManager.shared.addProduct(product, to: subId)
        let updatedProducts = MenuManager.shared.getProductsForSubcategory(subcategoryId: subId)
        tableView.createData(items: updatedProducts)
    }
}

extension ProductViewController: ProductCellDelegate {
    func productCellDidTapAddToCart(_ cell: ProductCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = products[indexPath.row]
        CartManager.shared.add(product)
        updateCartBadge()
    }
}

extension ProductViewController: CartManagerDelegate {
    func cartDidUpdate(_ manager: CartManager) {
        updateCartBadge()
    }
}

