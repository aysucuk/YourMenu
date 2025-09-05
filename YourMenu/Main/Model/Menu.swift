//
//  Menu.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import Foundation

struct Product: Codable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageName: String
    let subcategoryId: Int

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Product, rhs: Product) -> Bool { lhs.id == rhs.id }
}

struct Subcategory: Codable, Hashable {
    let id: Int
    let name: String
    var products: [Product]?
    var subcategories: [Subcategory]?
    
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Subcategory, rhs: Subcategory) -> Bool { lhs.id == rhs.id }
}

struct Category: Codable, Hashable {
    let id: Int
    let name: String
    var subcategories: [Subcategory]?
    var products: [Product]?
    
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Category, rhs: Category) -> Bool { lhs.id == rhs.id }
}

struct Menu: Codable {
    var categories: [Category]
}
