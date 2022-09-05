//
//  ContentView.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @StateObject private var users = Users()
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(cachedUsers){ user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                HStack{
                                    Text("Status -")
                                        .foregroundColor(.secondary)
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(user.isActive ? Color.green : Color.red)
                                        
                                }
                                .frame(height: 8)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if cachedUsers.count == 0 {
                    await DataInitialiser.cacheData(in: moc)
                }
            }
            .refreshable {
                await DataInitialiser.cacheData(in: moc)
            }
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
