//
//  SimplePencilkitApp.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/28.
//

import SwiftUI

@main
struct SimplePencilkitApp: App {
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
