//
//  ContentView.swift
//  Challenge 6
//
//  Created by Gabriel Marmen on 2022-09-19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var images = [UserImage]()
    @State private var isSheetShowing = false
    

    
    var body: some View {
        NavigationView{
            List{
                ForEach(images) { image in
                    NavigationLink(image.title){
                        DetailsView(image: $images.first(where: {$0.id == image.id})!)
                    }
                }
                Button("Add Item") {
                    images.append(UserImage.exempleImage)
                }
            }
            .toolbar{
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Images")
        }
        .onChange(of: images) { _ in
            images.sort()
        }
        .sheet(isPresented: $isSheetShowing){
            AddView(imagesList: $images)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
