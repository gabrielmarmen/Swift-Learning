//
//  AstronautView.swift
//  Project 8 (iOS)
//
//  Created by Gabriel Marmen on 2022-08-22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astraunaut

        var body: some View {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()

                    Text(astronaut.description)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
}

struct AstronautView_Previews: PreviewProvider {
    
    static var astronauts: [String:Astraunaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
