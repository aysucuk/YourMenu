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
    
    func loadCart() {
        items = CartManager.shared.items
        delegate?.cartDidUpdate(self)
    }
    
    func addToCart(_ product: Product) {
        CartManager.shared.add(product)
        items = CartManager.shared.items
        delegate?.cartDidUpdate(self)
    }
    
    func removeFromCart(_ product: Product) {
        CartManager.shared.remove(product)
        items = CartManager.shared.items
        delegate?.cartDidUpdate(self)
    }
}
