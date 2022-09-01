//
//  Project_12App.swift
//  Project 12
//
//  Created by Gabriel Marmen on 2022-09-01.
//

import SwiftUI

@main
struct Project_12App: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
