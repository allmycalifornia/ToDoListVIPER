//
//  CoreDataManager.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "TasksDataModel")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Error loading CoreData: \(error)")
//            }
//        }
//        return container
//    }()
//    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // Получаем viewContext из PersistenceController
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
                // Показ сообщения об ошибке пользователю
            }
        }
    }
}

