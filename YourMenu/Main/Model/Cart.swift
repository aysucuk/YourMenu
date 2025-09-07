//
//  Cart.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 07.09.25.
//

struct CartItem: Codable, Hashable {
    let product: Product
    var quantity: Int
    
    var subtotal: Double {
        return Double(quantity) * product.price
    }
    
}
