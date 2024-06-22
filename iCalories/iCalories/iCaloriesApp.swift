//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by manvendu pathak  on 22/06/24.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
