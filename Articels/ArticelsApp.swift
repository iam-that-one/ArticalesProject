//
//  ArticelsApp.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import SwiftUI

@main
struct ArticelsApp: App {
    var body: some Scene {
        let persistantContainer = CoreDataManager.shared.persistentContainer

        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
