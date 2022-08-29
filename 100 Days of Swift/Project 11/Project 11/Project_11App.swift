//
//  Project_11App.swift
//  Project 11
//
//  Created by Gabriel Marmen on 2022-08-29.
//

import SwiftUI

@main
struct Project_11App: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
