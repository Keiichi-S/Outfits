//
//  OutfitsApp.swift
//  Outfits
//
//  Created by 末包啓一 on 2020/12/25.
//

import SwiftUI

@main
struct OutfitsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
