//
//  EditProjectView.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 23/05/21.
//

import SwiftUI

struct EditProjectView: View {
    
    let project: Project
    
    @State private var title: String
    @State private var details: String
    @State private var color: String

    let colorColums = GridItem(.adaptive(minimum: 44))
    @EnvironmentObject var dataController: DataController
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    init(project: Project) {
        self.project = project

        _title = State(wrappedValue: project.projectTitle)
        _details = State(wrappedValue: project.projectDetails)
        _color = State(wrappedValue: project.projectColor)

    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Project Name", text: $title.onChange(update))
                TextField("Project Description", text: $details.onChange(update))
            }
            
            Section(header: Text("Customize Project Color")) {
                LazyVGrid(columns: [colorColums]) {
                    ForEach(Project.colors, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            if item == color {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .onTapGesture {
                            color = item
                            update()
                        }
                    }
                }    .padding(.vertical)

              
            }
            
            Section(footer: Text("Closing a project moves it from the Open to Closed tab; deleting it removes the project completely.")) {
                Button(project.closed ? "Reopen the project" : "Close the project"){
                    project.closed.toggle()
                    update()
                }
                
                Button("Delete this project") {
                    showingDeleteAlert = true
                }
                .accentColor(.red)
            }
            
        }
        .navigationTitle(Text("Edit Project"))
        .onDisappear(perform: dataController.save)

        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete project?"), message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
    }
    
    func update() {
        project.title = title
        project.details = details
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()

    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
