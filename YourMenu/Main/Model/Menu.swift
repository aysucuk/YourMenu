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
}

struct Subcategory: Codable, Hashable {
    let id: Int
    let name: String
    var products: [Product]?
    var subcategories: [Subcategory]?
}

struct Category: Codable, Hashable {
    let id: Int
    let name: String
    var subcategories: [Subcategory]?
    var products: [Product]?
}

struct Menu: Codable {
    var categories: [Category]
}
