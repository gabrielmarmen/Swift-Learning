//
//  DetailsView.swift
//  Challenge 6
//
//  Created by Gabriel Marmen on 2022-09-20.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var image: UserImage
    
    var body: some View {
        VStack(alignment: .leading){
            Image(image.imageURL.absoluteString)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .scaledToFit()
                .shadow(radius: 5)
                
            VStack(alignment: .leading){
                Text(image.title)
                    .font(.largeTitle)
                Text(image.description)
                    
            }
            .padding(.leading)
            Spacer()
        }
        .navigationTitle(image.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(image: .constant(UserImage.exempleImage))
    }
}
