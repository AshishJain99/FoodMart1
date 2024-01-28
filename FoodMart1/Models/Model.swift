//
//  Model.swift
//  FoodMart1
//
//  Created by Ashish Jain on 28/01/24.
//

import Foundation
struct ProductCategoryResponse: Codable {
    let status: Bool
    let message: String
    let error: String?
    let categories: [ProductCategory]
}

struct ProductCategory: Codable {
    let id: Int
    let name: String
    let items: [ProductItem]
}

struct ProductItem: Codable {
    public let id: Int
    public let name: String
    public let icon: String
    public let price: Double

}
