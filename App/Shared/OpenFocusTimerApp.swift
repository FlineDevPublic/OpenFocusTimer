//
//  OpenFocusTimerApp.swift
//  Shared
//
//  Created by Cihat Gündüz on 1/12/22.
//

import SwiftUI

@main
struct OpenFocusTimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
