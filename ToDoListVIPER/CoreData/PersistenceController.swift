//
//  Persistence.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 19.09.2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Пример данных для режима предпросмотра (Preview)
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newTask = TaskEntity(context: viewContext)
            newTask.title = "Sample Task"
            newTask.taskDescription = "This is a sample task for preview purposes"
            newTask.isCompleted = false
            newTask.createdAt = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // NSPersistentContainer для работы с CoreData
    let container: NSPersistentContainer

    // Инициализация контроллера
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TasksDataModel") // Убедитесь, что имя совпадает с моделью CoreData
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
