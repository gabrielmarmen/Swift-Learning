//
//  MissionView.swift
//  Project 8
//
//  Created by Gabriel Marmen on 2022-08-18.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astraunaut: Astraunaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading){
                        Text("Misssion Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astraunauts: [String: Astraunaut]) {
        self.mission = mission
        self.crew = mission.crew.map
        
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
