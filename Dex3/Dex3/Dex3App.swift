//
//  Dex3App.swift
//  Dex3
//
//  Created by José João Pimenta Oliveira on 21/12/2023.
//

import SwiftUI

@main
struct Dex3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
