//
//  MenuService.swift
//  YourMenu
//
//  Created by Aysu Sadikhova on 04.09.25.
//

import Foundation

class MenuService {
    static func loadMenu(completion: @escaping (Result<Menu, Error>) -> Void) {

        if let menu = MenuManager.shared.loadMenu() {
            completion(.success(menu))
        } else {
            completion(.failure(NSError(domain: "MenuService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Menu not found"])))
        }
    }
}
