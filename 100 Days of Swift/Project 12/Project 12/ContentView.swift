//
//  ContentView.swift
//  Project 12
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var filter = "A"
    
    
    enum Predicates: String {
        case beginsWith
    }
    
    var body: some View {
        VStack {
            FilteredList(filter: filter, predicate: .beginsWith, sortBy: .FamilyName)

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                filter = "A"
            }

            Button("Show S") {
                filter = "S"
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
