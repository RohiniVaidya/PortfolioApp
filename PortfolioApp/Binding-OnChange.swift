//
//  Binding-OnChange.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 22/05/21.
//

import SwiftUI

extension Binding {
    
    //This gives a completion handler for when a binding value changes. This handler helps to call the update on coredata
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            print("New Val = \(newValue)")
            handler()
        }
    }
    
}
