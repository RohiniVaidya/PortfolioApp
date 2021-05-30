//
//  Item-CoreDataHelpers.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 19/05/21.
//

import CoreData

extension Item {
    
    var itemTitle: String {
        title ?? ""
    }
    
    var itemDetail: String {
        details ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    var itemPriority: Int16 {
        priority ?? 0
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
