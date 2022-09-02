//
//  DetailView.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-02.
//

import SwiftUI

struct DetailView: View {
    
    @State var user: User
    
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
                    Text(user.company)
                        .foregroundColor(Color.secondary)
                    
                    Text(String(user.age) + " years old")
                        .foregroundColor(Color.secondary)
                }
                
                
                List{
                    ForEach(user.friends){ friend in
                        Text(friend.name)
                    }
                    
                }
            }
            
        
    }
}

struct DetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        DetailView(user: User(id: UUID(), isActive: true, name: "Gabriel Marmen", age: 24, company: "CISSSBSL", friends: [Friend]()))
    }
}
