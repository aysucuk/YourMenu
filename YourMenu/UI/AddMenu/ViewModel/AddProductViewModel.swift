//
//  AddProductViewModel.swift
//  YourMenu
//
//  Created by Aysu Sadıxova on 06.09.25.
//

import Foundation

protocol AddProductViewModelDelegate: AnyObject {
    func productCreated(_ product: Product)
    func validationError(_ message: String)
}

protocol AddProductViewModelProtocol: AnyObject {
    var delegate: AddProductViewModelDelegate? { get set }
    func createProduct(name: String?, description: String?, priceText: String?, subcategoryId: Int?)
}

class AddProductViewModelImpl: AddProductViewModelProtocol {
    
    weak var delegate: AddProductViewModelDelegate?
    
    func createProduct(
        name: String?,
        description: String?,
        priceText: String?,
        subcategoryId: Int?
    ) {
        guard let name = name, !name.isEmpty else {
                   delegate?.validationError("Ad boş ola bilməz")
                   return
               }
        guard let description = description, !description.isEmpty else {
                   delegate?.validationError("Təsvir boş ola bilməz")
                   return
               }
        guard let priceText = priceText, let price = Double(priceText) else {
                   delegate?.validationError("Qiymət rəqəm olmalıdır")
                   return
               }
        let product = Product(
            id: Int.random(in: 1000...9999),
            name: name,
            description: description,
            price: price,
            imageName: "default",
            subcategoryId: subcategoryId ?? 0
        )
        
        delegate?.productCreated(product)
    }
}
