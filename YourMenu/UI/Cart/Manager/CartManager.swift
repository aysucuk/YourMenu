//
//  CartManager.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 07.09.25.
//

import Foundation

protocol CartManagerDelegate: AnyObject {
    func cartDidUpdate(_ manager: CartManager)
}

class CartManager {
    
    static let shared = CartManager()
    weak var delegate: CartManagerDelegate?

    private init() {}
    
    private(set) var items: [CartItem] = []
    
    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
        delegate?.cartDidUpdate(self)
    }
    
    func remove(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
            delegate?.cartDidUpdate(self)
        }
    }
    
    func clear() {
        items.removeAll()
        delegate?.cartDidUpdate(self)
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }
}
