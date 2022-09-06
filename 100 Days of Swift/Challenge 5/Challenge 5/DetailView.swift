//
//  DetailView.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import SwiftUI

struct DetailView: View {
    
    @State var user: User
    @ObservedObject var users: Users
    
    var body: some View {
        
            VStack{
                Group{
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .shadow(radius: 5)
                    Text(user.name)
                        .font(.title)
                    Text(user.name)
                        .foregroundColor(Color.secondary)
                    
                    Text(String(user.age) + " years old")
                        .foregroundColor(Color.secondary)
                }
                
                
                List{
                    ForEach(user.friends){ friend in
                        NavigationLink(friend.name){
                            DetailView(user: users.getUser(from: friend), users: users)
                        }
                    }
                    
                }
            }
            
        
    }
}


