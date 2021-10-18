//
//  HomeView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 19/05/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    static let tag: String? = "Home"
    @EnvironmentObject var dataController: DataController
    
    var rows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>

    var items: FetchRequest<Item>
    
    init() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let completedPredicate = NSPredicate(format: "completed = false")
        let openPredicate = NSPredicate(format: "project.closed = false", <#T##args: CVarArg...##CVarArg#>)
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
        request.predicate = compoundPredicate
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.priority, ascending: false)
        ]
        request.fetchLimit = 10
        items = FetchRequest(fetchRequest: request)
        print("Items \(items.wrappedValue.count)")
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows) {
                        ForEach(projects, content: ProjectSummaryView.init)
                    }
                    .padding([.horizontal, .top])
                }
                .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading) {
                    ItemListView(title: "Up Next", items: items.wrappedValue.prefix(3))
                    ItemListView(title: "More to explore", items: items.wrappedValue.dropFirst(3))
                }
                .padding(.horizontal)
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
            .navigationBarItems(trailing: trailing)
        }
       
       
    }
    
    var trailing: some View {
        Button("Add Data") {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
    
}


   

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
