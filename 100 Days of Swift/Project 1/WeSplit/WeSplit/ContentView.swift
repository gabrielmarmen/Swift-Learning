//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriel Marmen on 2022-08-01.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0
    @State private var name = ""
    
    var body: some View {

        NavigationView
        {
            Form{
                Section{
                    Text("Hello, word!")
                    
                }
                Section{
                    Button("Up Up Up"){
                        count += 1
                    }
                    Text("Count is : \(count)")
                }
                
                Section{
                    Text("Your name is \(name)")
                    TextField("Enter Your Name", text: $name)
                }
                
                
            }
            .navigationTitle("Sheesh")
            
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
