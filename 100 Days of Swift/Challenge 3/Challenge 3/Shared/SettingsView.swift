//
//  SettingsView.swift
//  Challenge 3 (iOS)
//
//  Created by Gabriel Marmen on 2022-08-12.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var multiplyBy = 2
    
    
    var body: some View {
        NavigationView{
            List{
                Stepper("Multiply by : \(multiplyBy)", value: $multiplyBy, in: 2...12)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
