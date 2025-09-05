//
//  ViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//


import UIKit

class ProductViewController: UIViewController {
    
    internal var tableView: ProductTableView = {
       let view = ProductTableView()
        view.rowHeight = 70
        return view
    }()
    
    private var products: [Product]

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
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func setupData() {
        tableView.createData(items: products)
    }

}
