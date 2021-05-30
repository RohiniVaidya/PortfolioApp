//
//  EditItemView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 20/05/21.
//

import SwiftUI

struct EditItemView: View {
    
    var item: Item
    @State private var title: String
    @State private var details: String
    @State private var priority: Int
    @State private var completed: Bool

    @EnvironmentObject var dataController: DataController
    init(item: Item) {
        self.item = item
        
        _title = State(wrappedValue: item.itemTitle)
        _details = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)

    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")){
                TextField("Title", text: $title.onChange(update))
                TextField("Details", text: $details.onChange(update))
            }
            Section(header: Text("Priority")) {
                Picker("priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
            }
            
            Section {
                Toggle("Mark Completed", isOn: $completed.onChange(update))
            }
        }
        .navigationTitle(Text("Edit Item"))
        .onDisappear(perform: dataController.save)
    }
    
    private func update() {
        item.project?.objectWillChange.send()
        
        item.title = title
        item.details = details
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
