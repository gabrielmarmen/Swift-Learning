//
//  ContentView.swift
//  Shared
//
//  Created by Gabriel Marmen on 2022-08-15.
//

import SwiftUI

struct ContentView: View {
    
    @State var listViewEnabled: Bool = false
    
    let astraunauts: [String: Astraunaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !listViewEnabled {
                    LazyVGrid(columns: columns){
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astraunauts)
                            } label: {
                                VStack{
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedDate)
                                            .foregroundColor(.white)
                                            .opacity(0.5)
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                                
                                
                            }
                        }
                    }
                    .padding([.horizontal,.bottom])
                }
                else{
                    LazyVStack{
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astraunauts)
                            } label: {
                                VStack{
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedDate)
                                            .foregroundColor(.white)
                                            .opacity(0.5)
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                                .padding(.bottom)
                                
                                
                            }
                        }
                    }
                    .padding([.horizontal,.bottom])
                }
                
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(listViewEnabled ? "Grid View" : "List View"){
                    listViewEnabled.toggle()
                }
                .foregroundColor(.secondary)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
