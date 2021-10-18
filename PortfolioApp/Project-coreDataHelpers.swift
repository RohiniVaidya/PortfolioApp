//
//  Project-coreDataHelpers.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 19/05/21.
//

import CoreData
import SwiftUI
extension Project {
    
    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]
    
    var projectTitle: String {
        title ?? "New Project"
    }
    
    var projectDetails: String {
        details ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    
    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }
    
    var projectItemsDefaultSorted: [Item] {
        projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {return true}
            }
            else if first.completed == true {
                if second.completed == false {return false}
            }
            if first.priority > second.priority {
                return true
            }
            else if first.priority < second.priority {
                return false
            }
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var label: LocalizedStringKey {
        return "\(projectTitle), \(projectItems.count) items, \(completionAmount * 100, specifier: "%g")% complete."
    }
    
 
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
    
    static var example: Project {
        let controller = DataController(inMemory: true)
        let context = controller.container.viewContext
        let project = Project(context: context)
        project.title = "Example Project"
        project.creationDate = Date()
        project.details = "This is an example project"
        project.closed = true
        return project
    }
    
    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .optimized:
            return projectItemsDefaultSorted
        case .creationDate:
            return projectItems.sorted(by: \Item.itemCreationDate)
        case .title:
            return projectItems.sorted(by: \Item.itemTitle)
        }
    }

}
