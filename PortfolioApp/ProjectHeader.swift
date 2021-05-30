//
//  ProjectHeader.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 22/05/21.
//

import SwiftUI

struct ProjectHeader: View {
    
    @ObservedObject var project: Project
    
    var body: some View {
        HStack {
            VStack{
                Text(project.projectTitle)
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            Spacer()
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "pencil.circle.fill")
                    .imageScale(.large)
            }
            
        }
        .padding(.bottom, 10)
        
    }
}

struct ProjectHeader_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeader(project: Project.example)
    }
}
