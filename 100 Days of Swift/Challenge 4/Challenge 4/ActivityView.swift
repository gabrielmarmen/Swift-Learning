//
//  ActivityView.swift
//  Challenge 4
//
//  Created by Gabriel Marmen on 2022-08-23.
//

import SwiftUI


struct ActivityView: View {
    
    @ObservedObject var activities: Activities
    @State private var editShowing = false
    let activity: Activity
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                VStack(alignment: .leading){
                    Text(activity.description)
                        .font(.body)
                }
                .navigationTitle(activity.title)
                .toolbar{
                    Button("Edit"){
                        
                    }
                }
                
            }
        }
        .sheet(isPresented: $editShowing){
            NavigationView{
                Form{
                    Section{
                        TextField("Title", text: activity.title)
                    }
                    Section{
                        TextField("Description", text: activity.de)
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
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities(), activity: Activity(title: "Test", description: "test"))
    }
}
