//
//  ProductViewModel.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 08.09.25.
//

protocol ProductViewModelDelegate: AnyObject {
    func productViewModel(_ viewModel: ProductViewModelProtocol, didUpdateProducts products: [Product])
    func productViewModel(_ viewModel: ProductViewModelProtocol, didUpdateCart count: Int)
}

protocol ProductViewModelProtocol: AnyObject {
    var delegate: ProductViewModelDelegate? { get set }
    var products: [Product] { get }
    
    func loadProducts(subcategoryId: Int?)
    func addProduct(_ product: Product, to subcategoryId: Int)
    func addToCart(_ product: Product)
    func cartItemCount() -> Int
}

class ProductViewModelImpl: ProductViewModelProtocol {
    
    weak var delegate: ProductViewModelDelegate?
    
    private let menuManager: MenuManager = .shared
    private let cartManager: CartManager = .shared
    
    var products: [Product] = []
    
    init() {
        cartManager.delegate = self
    }
    
    func loadProducts(subcategoryId: Int?) {
        if let subId = subcategoryId {
            products = menuManager.getProductsForSubcategory(subcategoryId: subId)
        } else {
            products = []
        }
        delegate?.productViewModel(self, didUpdateProducts: products)
        delegate?.productViewModel(self, didUpdateCart: cartItemCount())
    }
    
    func addProduct(_ product: Product, to subcategoryId: Int) {
        menuManager.addProduct(product, to: subcategoryId)
        loadProducts(subcategoryId: subcategoryId)
    }
    
    func addToCart(_ product: Product) {
        cartManager.add(product)
        delegate?.productViewModel(self, didUpdateCart: cartItemCount())
    }
    
    func cartItemCount() -> Int {
        return cartManager.items.reduce(0) { $0 + $1.quantity }
    }
}

extension ProductViewModelImpl: CartManagerDelegate {
    func cartDidUpdate(_ manager: CartManager) {
        delegate?.productViewModel(self, didUpdateCart: cartItemCount())
    }
}
