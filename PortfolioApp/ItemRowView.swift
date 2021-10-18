//
//  ItemRowView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 20/05/21.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var project: Project
    @ObservedObject var item: Item
    //diference btw @StateObject & @ObservedObject is the former tells that the staate of that object is created & maintained by itself. WHile later says that Someone else creates it while I still subscribe to it & observe for any change
    
    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(project.projectColor))
        }
        else if item.itemPriority == 3 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(project.projectColor))
            
        }
        return Image(systemName: "checkmark.circle")
            .foregroundColor(Color.clear)
    }
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Label {
                Text(item.itemTitle)
            } icon: {
                icon
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
