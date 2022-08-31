//
//  RatingView.swift
//  Project 11
//
//  Created by Gabriel Marmen on 2022-08-31.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
