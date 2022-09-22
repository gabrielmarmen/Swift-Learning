//
//  AddView.swift
//  Challenge 6
//
//  Created by Gabriel Marmen on 2022-09-20.
//

import SwiftUI

struct AddView: View {
    
    @Binding var imagesList: [UserImage]
    @State private var title = ""
    @State private var description = ""
    @State private var image: Image?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List{
            TextField("title", text: $title)
            TextField("Description", text: $description)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        
        AddView(imagesList: .constant([UserImage]()))
    }
}
