//
//  easydoApp.swift
//  easydo
//
//  Created by Zayn on 12/7/21.
//

import SwiftUI
//MAIN APP
@main
struct easydoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
