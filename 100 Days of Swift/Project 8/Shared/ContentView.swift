//
//  ContentView.swift
//  Shared
//
//  Created by Gabriel Marmen on 2022-08-15.
//

import SwiftUI

struct ContentView: View {
    
    let astraunauts: [String: Astraunaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink {
                            Text("Detail view")
                        } label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedDate)
                                }
                                .frame(width: .infinity)
                            }
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("MoonShot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
