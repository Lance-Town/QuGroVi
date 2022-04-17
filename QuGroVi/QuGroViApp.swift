//
//  QuGroViApp.swift
//  QuGroVi
//
//  Created by Lance Townsend on 3/24/22.
//

import SwiftUI

@main
struct QuGroViApp: App {
    // Data controller for CoreData
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
