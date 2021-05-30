//
//  ItemRowView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 20/05/21.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var item: Item
    //diference btw @StateObject & @ObservedObject is the former tells that the staate of that object is created & maintained by itself. WHile later says that Someone else creates it while I still subscribe to it & observe for any change
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item.example)
    }
}
