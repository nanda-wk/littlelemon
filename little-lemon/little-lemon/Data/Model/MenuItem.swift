//
//  MenuItem.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

struct MenuItem: Codable {
    let id: Int
    let title: String
    let menuDescription: String
    let price: String
    let image: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case menuDescription = "description"
        case price
        case image
        case category
    }
}
