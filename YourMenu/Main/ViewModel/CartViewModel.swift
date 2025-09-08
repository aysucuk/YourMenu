//
//  CartViewModel.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 07.09.25.
//

import Foundation

protocol CartViewModelDelegate: AnyObject {
    func cartDidUpdate(_ viewModel: CartViewModelProtocol)
}

protocol CartViewModelProtocol: AnyObject {
    var items: [CartItem] { get }
    var delegate: CartViewModelDelegate? { get set }
    
    func loadCart()
    func addToCart(_ product: Product)
    func removeFromCart(_ product: Product)
}

class CartViewModelImpl: CartViewModelProtocol {
    
    private(set) var items: [CartItem] = []
    weak var delegate: CartViewModelDelegate?
    private let manager: CartManager = .shared
    
    func loadCart() {
        items = manager.items
        delegate?.cartDidUpdate(self)
    }
    
    func addToCart(_ product: Product) {
        manager.add(product)
        items = manager.items
        delegate?.cartDidUpdate(self)
    }
    
    func removeFromCart(_ product: Product) {
        manager.remove(product)
        items = manager.items
        delegate?.cartDidUpdate(self)
    }
}
