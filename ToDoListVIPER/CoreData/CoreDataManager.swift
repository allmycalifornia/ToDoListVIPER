//
//  CoreDataManager.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context: NSManagedObjectContext
    
    private init() {
        context = PersistenceController.shared.container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

