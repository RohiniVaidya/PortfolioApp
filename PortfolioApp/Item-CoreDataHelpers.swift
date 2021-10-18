//
//  Item-CoreDataHelpers.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 19/05/21.
//

import CoreData

extension Item {
    
    enum SortOrder {
        case optimized, title, creationDate
    }
    
    var itemTitle: String {
        title ?? "New Item"
    }
    
    var itemDetail: String {
        details ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    var itemPriority: Int16 {
        priority
    }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let context = controller.container.viewContext
        let item = Item(context: context)
        item.title = "Example Item"
        item.creationDate = Date()
        item.completed = false
        return item
    }
    
}
