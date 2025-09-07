//
//  AddProductViewController.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 06.09.25.
//


import UIKit

protocol AddProductViewControllerDelegate: AnyObject {
    func addProductViewController(_ controller: AddProductViewController, didSave product: Product)
}

class AddProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var subcategoryId: Int?
    weak var delegate: AddProductViewControllerDelegate?
    
    private lazy var viewModel: AddProductViewModelProtocol = {
        let vm = AddProductViewModelImpl()
        vm.delegate = self 
        return vm
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                title = "Yeni Məhsul"
                view.backgroundColor = .systemGroupedBackground
                
                view.addSubview(tableView)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                
        tableView.register(AddProductCell.self, forCellReuseIdentifier: AddProductCell.description())
                tableView.dataSource = self
                tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    func saveProduct(_ product: Product) {
            delegate?.addProductViewController(self, didSave: product)
        }
    
    @objc private func saveTapped() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddProductCell else {
            return
        }
        
        let name = cell.nameText
        let description = cell.descriptionText
        let priceText = cell.priceText
        
        viewModel.createProduct(
            name: name,
            description: description,
            priceText: priceText,
            subcategoryId: subcategoryId
        )
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddProductCell.description(), for: indexPath) as? AddProductCell else {
            return UITableViewCell()
        }
        return cell
    }

}

extension AddProductViewController: AddProductViewModelDelegate {
    func productCreated(_ product: Product) {
        delegate?.addProductViewController(self, didSave: product)
        navigationController?.popViewController(animated: true)
    }
    
    func validationError(_ message: String) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddProductCell {
            cell.showError(message: message)
        }
    }
}
