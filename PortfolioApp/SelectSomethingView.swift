//
//  SelectSomethingView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 30/05/21.
//

import SwiftUI

struct SelectSomethingView: View {
    var body: some View {
        Text("Please select something from the menu to begin.")
                    .italic()
                    .foregroundColor(.secondary)
    }
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}
