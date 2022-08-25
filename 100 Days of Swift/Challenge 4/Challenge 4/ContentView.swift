//
//  ContentView.swift
//  Challenge 4
//
//  Created by Gabriel Marmen on 2022-08-23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var addIsPresented = false
    
    @StateObject private var activities = Activities()
    
    
    var body: some View {
        NavigationView{
                List{
                    ForEach(activities.items) { activity in
                        NavigationLink(activity.title){
                            ActivityView(activities: activities, activity: activity)
                        }
                        .padding()
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationTitle("Habits")
                .toolbar{
                    Button(){
                        addIsPresented.toggle()
                    }label: {
                        Image(systemName: "plus")
                    }
                    
                }
                .listStyle(.grouped)
        }
        .sheet(isPresented: $addIsPresented) {
            AddItemSheet(activities: activities)
        }
    }
    
    func deleteItem(at offsets: IndexSet){
        let tempItem = activities.items[offsets.first ?? 0]
        activities.items.removeAll(where: {$0.id == tempItem.id})
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
