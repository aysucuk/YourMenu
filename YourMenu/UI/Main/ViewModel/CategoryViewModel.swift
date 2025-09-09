//
//  CategoryViewModel.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    var categories: [Category] { get }
    var selectedCategoryIndex: Int { get set }

    func loadMenu()
    var delegate: CategoryViewModelDelegate? { get set }
}

protocol CategoryViewModelDelegate: AnyObject {
    func didLoadMenu()
    func didFailLoadingMenu(error: Error)
}

class CategoryViewModelImpl: CategoryViewModelProtocol {
    weak var delegate: CategoryViewModelDelegate?
    private var menu: Menu?
    var selectedCategoryIndex: Int = 0

    var categories: [Category] {
        menu?.categories ?? []
    }

    func loadMenu() {
        MenuService.loadMenu { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menu):
                    self?.menu = menu
                    self?.delegate?.didLoadMenu()
                case .failure(let error):
                    self?.delegate?.didFailLoadingMenu(error: error)
                }
            }
        }
    }
}
