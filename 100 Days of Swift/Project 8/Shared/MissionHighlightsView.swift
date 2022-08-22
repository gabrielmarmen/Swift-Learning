//
//  MissionHighlightsView.swift
//  Project 8 (iOS)
//
//  Created by Gabriel Marmen on 2022-08-22.
//

import SwiftUI

struct MissionHighlightsView: View {
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading){
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.vertical)
            
            Text("Misssion Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.top, 5)
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
    }
}

struct MissionHighlightsView_Previews: PreviewProvider {
    
    static var missions: [Mission] =  Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionHighlightsView(mission: missions[0])
    }
}
