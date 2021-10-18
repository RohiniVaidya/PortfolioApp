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
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @State private var showingActionSheet = false
    @State private var sortOrder = Item.SortOrder.optimized
    
    init(showClosedProject: Bool) {
        //since we cannot use @FetchRequest as we do not know if it has to be open or closed project. Hence we are not using the propertyWrapper of FetchRequest but we are using the underlying struct and create it by hand and use that to show the results.
        self.showClosedProject = showClosedProject
        
        projects = FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProject))
        
    }
    
    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    Text("No projects yet!")
                        .foregroundColor(.secondary)
                }
                else {
                    List {
                        ForEach(projects.wrappedValue) { project in
                            Section(header: ProjectHeader(project: project)) {
                                //In coredata often when we add relationships, we get the items as Set & not an array, hence we are getting allObjects = array
                                
                                ForEach(project.projectItems(using: sortOrder)) { item in
                                    ItemRowView(project: project, item: item)
                                }
                                .onDelete { offsets in
                                    let allItems = project.projectItems(using: sortOrder)

                                    for offset in offsets {
                                        let item = allItems[offset]
                                        dataController.delete(item)
                                    }

                                    dataController.save()
                                }
                                if showClosedProject == false {
                                    Button {
                                        withAnimation {
                                            let item = Item(context: managedObjectContext)
                                            item.project = project
                                            item.creationDate = Date()
                                            dataController.save()
                                        }
                                    } label: {
                                        Label("Add New Item", systemImage: "plus")
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
            }
            .navigationTitle(Text(showClosedProject ? "Closed Projects" : "Open Projects"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !showClosedProject {
                        Button(action: {
                            
                            withAnimation {
                                let project = Project(context: managedObjectContext)
                                project.creationDate = Date()
                                project.closed = false
                                dataController.save()
                            }
                            
                        }){
                            Label("Add Project", systemImage: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingActionSheet = true
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Sort Items"), message: Text(""), buttons: [
                    .default(Text("Optimized"), action: { sortOrder = .optimized }),
                    .default(Text("Title"), action: {sortOrder = .title }),
                    .default(Text("Creation Date"), action: {sortOrder = .creationDate})
                ])
            }
            SelectSomethingView()
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
