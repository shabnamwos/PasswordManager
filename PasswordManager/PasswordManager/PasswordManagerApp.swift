//
//  PasswordManagerApp.swift
//  PasswordManager
//
//  Createdby Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

@main
struct PasswordManagerApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(size: CGSize(width: 150.0, height: 150.0))
            
//            HomeView()
//            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


