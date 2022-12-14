//
//  DetailView.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var user: CachedUser
    @FetchRequest(sortDescriptors: [] ) var cachedUsers: FetchedResults<CachedUser>
    
    
    var body: some View {
        
            VStack{
                Group{
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .shadow(radius: 5)
                    Text(user.wrappedName)
                        .font(.title)
                    Text(user.wrappedCompany)
                        .foregroundColor(Color.secondary)
                    
                    Text(String(user.age) + " years old")
                        .foregroundColor(Color.secondary)
                }
                
                
                List{
                    ForEach(user.wrappedArrayFriends){ friend in
                        NavigationLink(friend.wrappedName){
                            DetailView(user: GetCachedUser(from: friend))
                        }
                    }
                    
                }
            }
            
        
    }
    
    func GetCachedUser(from friend: CachedFriend) -> CachedUser {
        
        return cachedUsers.first(where: {$0.id == friend.id})!
    }
}


