//
//  miser_moneytrackApp.swift
//  miser_moneytrack
//
//  Created by 本村喜大 on 2024/05/21.
//

import SwiftUI


struct miser_moneytrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
