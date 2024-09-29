//
//  PersistenceController.swift
//  SimplePencilkit
//
//  Created by 小林達弥 on 2024/09/29.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "Simple_Pencilkit")
        container.loadPersistentStores(completionHandler:   {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresoleve Store error: \(error)")
            }
        })
    }
}
