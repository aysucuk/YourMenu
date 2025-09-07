//
//  ViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//


import UIKit

class ProductViewController: UIViewController, AddProductViewControllerDelegate {
   
    internal var tableView: ProductTableView = {
       let view = ProductTableView()
        return view
    }()
    
    private var products: [Product]
    var subcategoryId: Int?

    init(products: [Product], title: String) {
        self.products = products
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewProduct)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(closeTapped)
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
    
    private func setupData() {
        tableView.createData(items: products)
    }
    
    func reloadData(_ products: [Product]) {
            self.products = products
            tableView.reloadData()
        }
    
    @objc private func closeTapped() {
        self.dismiss(animated: true)
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
        MenuManager.shared.addProduct(product, to: subId)
        let updatedProducts = MenuManager.shared.getProductsForSubcategory(subcategoryId: subId)
        tableView.createData(items: updatedProducts)
    }
}
