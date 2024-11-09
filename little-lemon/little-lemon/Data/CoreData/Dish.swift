//
//  Dish.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import CoreData
import Foundation

final class Dish: NSManagedObject, Identifiable {
    @NSManaged var id: Int64
    @NSManaged var title: String
    @NSManaged var price: String
    @NSManaged var menuDescription: String
    @NSManaged var image: String
    @NSManaged var category: String
}

extension Dish {
    func fromMenuItem(_ menuItem: MenuItem) {
        id = Int64(menuItem.id)
        title = menuItem.title
        price = menuItem.price
        menuDescription = menuItem.menuDescription
        image = menuItem.image
        category = menuItem.category
    }

    static func preview() -> Dish {
        let dish = Dish(context: PersistenceController.shared.container.viewContext)
        dish.id = 1
        dish.title = "Dish Title"
        dish.price = "10.00"
        dish.menuDescription = "Dish Description"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/pasta.jpg?raw=true"
        dish.category = "Category"
        return dish
    }
}
