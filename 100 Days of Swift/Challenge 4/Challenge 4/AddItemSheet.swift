//
//  AddItemSheet.swift
//  Challenge 4
//
//  Created by Gabriel Marmen on 2022-08-23.
//

import Foundation
import SwiftUI

struct AddItemSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    
    @ObservedObject var activities: Activities
    
    var body: some View{
        NavigationView{
            Form{
                Section{
                   TextField("Title", text: $title)
                }
                Section{
                    TextField("Description", text: $description)
                }
            }
            .toolbar {
                HStack{
                    Button("Dismiss"){
                        dismiss()
                    }
                    
                    Button("Add"){
                        activities.items.append(Activity(title: title, description: description))
                        dismiss()
                    }
                    .disabled(title != "" && description != "" ? false : true)
                }
            }
            .navigationTitle("Add Habit")
        }
    }
}
