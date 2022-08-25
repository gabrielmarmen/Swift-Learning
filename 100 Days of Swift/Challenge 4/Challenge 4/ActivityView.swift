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
    
    var index: Int{
        activities.items.firstIndex(where: {$0.id == activity.id}) ?? 0
    }
    
    var body: some View {
        GeometryReader{ geo in
            
                VStack{
                    Text(activity.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                    Text(activity.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("You've completed this habit \(activities.items[index].completedCounter) times")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button("Complete"){
                        activities.items[index].complete()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                .padding()
        }

        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities(), activity: Activity(title: "Test", description: "test"))
    }
}
