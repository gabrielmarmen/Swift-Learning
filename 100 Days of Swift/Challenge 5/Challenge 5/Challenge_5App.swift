//
//  Challenge_5App.swift
//  Challenge 5
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI

@main
struct Challenge_5App: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
