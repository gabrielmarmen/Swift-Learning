//
//  ContentView.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var users = Users()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(users.items){ user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading) {
                                Text(user.name)
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
                if users.items.isEmpty {
                        await loadData()
                }
            }
            .refreshable {
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users.items = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
