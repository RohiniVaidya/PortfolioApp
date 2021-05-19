//
//  ProjectsView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 19/05/21.
//

import SwiftUI

struct ProjectsView: View {
    
    let showClosedProject: Bool
    let projects: FetchRequest<Project>
    
    
    init(showClosedProject: Bool) {
        //since we cannot use @FetchRequest as we do not know if it has to be open or closed project. Hence we are not using the propertyWrapper of FetchRequest but we are using the underlying struct and create it by hand and use that to show the results.
        self.showClosedProject = showClosedProject
        
        projects = FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProject))
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.title ?? "")) {
                        //In coredata often when we add relationships, we get the items as Set & not an array, hence we are getting allObjects = array

                        ForEach(project.items?.allObjects as? [Item] ?? []) { item in
                            Text(item.title ?? "")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text(showClosedProject ? "Closed Projects" : "Open Projects"))
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProject: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
