//
//  CategoryViewController.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import UIKit

class CategoryViewController: UIViewController {

    private lazy var viewModel: CategoryViewModelProtocol = {
        let vm = CategoryViewModelImpl()
        vm.delegate = self
        return vm
    }()

    private let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private var tableView = CategoryTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menyu"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground

        tableView.selectionDelegate = self
        setupUI()

        MenuManager.shared.initializeDefaultMenuIfNeeded()
        viewModel.loadMenu()
    }

    private func setupUI() {
        topCollectionView.showsHorizontalScrollIndicator = false
        topCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        topCollectionView.dataSource = self
        topCollectionView.delegate = self

        view.addSubview(topCollectionView)
        view.addSubview(tableView)
        
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            topCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topCollectionView.heightAnchor.constraint(equalToConstant: 60),
            

            tableView.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func reloadData() {
        topCollectionView.reloadData()
        if let category = viewModel.categories[safe: viewModel.selectedCategoryIndex] {
            tableView.items = category.subcategories ?? []
        }
    }
}

extension CategoryViewController: GenericTableViewControllerDelegate {
    func didSelectItem(_ item: Any) {
        if let subcategory = item as? Subcategory {
            let products = MenuManager.shared.getProductsForSubcategory(subcategoryId: subcategory.id)
            let productVC = ProductViewController(products: products, title: subcategory.name)
         //   navigationController?.pushViewController(productVC, animated: true)
            productVC.subcategoryId = subcategory.id
            let navVC = UINavigationController(rootViewController: productVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
        }
    }
}

extension CategoryViewController: CategoryViewModelDelegate {
    func didLoadMenu() { reloadData() }
    func didFailLoadingMenu(error: Error) { print("Error loading menu: \(error.localizedDescription)") }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = viewModel.categories[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel()
        label.text = category.name
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        cell.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])

        cell.backgroundColor = (indexPath.item == self.viewModel.selectedCategoryIndex) ? .systemOrange : .systemGray5
        cell.layer.cornerRadius = 12
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedCategoryIndex = indexPath.item
        reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.categories[indexPath.item].name
        let width = (text as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium)]).width + 24
        return CGSize(width: width, height: 45)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
