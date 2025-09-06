//
//  AddProductViewModel.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 06.09.25.
//

import Foundation

protocol AddProductViewModelProtocol: AnyObject {
    var onProductCreated: ((Product) -> Void)? { get set }
    func createProduct(name: String?, description: String?, priceText: String?, subcategoryId: Int?)
}

class AddProductViewModelImpl: AddProductViewModelProtocol {
    
    var onProductCreated: ((Product) -> Void)?
    
    func createProduct(
        name: String?,
        description: String?,
        priceText: String?,
        subcategoryId: Int?
    ) {
        guard
            let name = name, !name.isEmpty,
            let description = description, !description.isEmpty,
            let priceText = priceText,
            let price = Double(priceText)
        else {
            return
        }
        
        let product = Product(
            id: Int.random(in: 1000...9999),
            name: name,
            description: description,
            price: price,
            imageName: "",
            subcategoryId: subcategoryId ?? 0
        )
        
        onProductCreated?(product)
    }
}
