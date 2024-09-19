//
//  TasksInteractor.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

//import Foundation
//import CoreData

//class TasksInteractor: PresenterToInteractorProtocol {
//    var presenter: InteractorToPresenterProtocol?
//    
//    // Получение задач из CoreData
//    func fetchTasks() {
//        DispatchQueue.global().async {
//            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//            do {
//                let tasks = try CoreDataManager.shared.context.fetch(fetchRequest)
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchedSuccess(tasks: tasks)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchedFailed()
//                }
//            }
//        }
//    }
//
//    // Добавление новой задачи
//    func addTask(title: String, taskDescription: String) {
//        DispatchQueue.global().async {
//            let newTask = TaskEntity(context: CoreDataManager.shared.context)
//            newTask.title = title
//            newTask.taskDescription = taskDescription
//            newTask.isCompleted = false
//            newTask.createdAt = Date()
//
//            CoreDataManager.shared.saveContext()
//            
//            self.fetchTasks()
//        }
//    }
//
//    // Удаление задачи
//    func deleteTask(task: TaskEntity) {
//        DispatchQueue.global().async {
//            CoreDataManager.shared.context.delete(task)
//            CoreDataManager.shared.saveContext()
//            self.fetchTasks()
//        }
//    }
//
//    // Обновление задачи
//    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
//        DispatchQueue.global().async {
//            task.title = title
//            task.taskDescription = taskDescription
//            task.isCompleted = isCompleted
//            CoreDataManager.shared.saveContext()
//            self.fetchTasks()
//        }
//    }
//
//    // Загрузка задач из API
//    func fetchTasksFromAPI() {
//        TasksAPIService.shared.fetchTasks { [weak self] tasks in
//            guard let self = self, let tasks = tasks else { return }
//
//            // Сохранение в CoreData
//            self.saveTasksToCoreData(apiTasks: tasks)
//        }
//    }
//
//    // Сохранение задач из API в CoreData
//    private func saveTasksToCoreData(apiTasks: [ToDoItem]) {
//        apiTasks.forEach { apiTask in
//            let newTask = TaskEntity(context: CoreDataManager.shared.context)
//            newTask.title = String(apiTask.id)
//            newTask.title = apiTask.todo
//            newTask.isCompleted = apiTask.completed
//            newTask.createdAt = Date()
//
//            // Сохранение в CoreData
//            CoreDataManager.shared.saveContext()
//        }
//        
//        // Фетч после сохранения
//        self.fetchTasks()
//    }
//}

//import Foundation
//import CoreData
//
//class TasksInteractor: PresenterToInteractorProtocol {
//    var presenter: InteractorToPresenterProtocol?
//    
//    func fetchTasks() {
//        let tasks = fetchTasksFromCoreData() // или fetchTasksFromAPI()
//        presenter?.tasksFetchedSuccess(tasks: tasks)
//    }
//    
//    // Добавление метода fetchTasksFromCoreData
//    private func fetchTasksFromCoreData() -> [TaskEntity] {
//        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//        do {
//            let tasks = try CoreDataManager.shared.context.fetch(fetchRequest)
//            return tasks
//        } catch {
//            print("Failed to fetch tasks from CoreData: \(error)")
//            return []
//        }
//    }
//
//    // Метод для добавления новой задачи
//    func addTask(title: String, taskDescription: String) {
//        DispatchQueue.global().async {
//            let newTask = TaskEntity(context: CoreDataManager.shared.context)
//            newTask.title = title
//            newTask.taskDescription = taskDescription
//            newTask.isCompleted = false
//            newTask.createdAt = Date()
//
//            CoreDataManager.shared.saveContext()
//            
//            self.fetchTasks()
//        }
//    }
//
//    // Метод для удаления задачи
//    func deleteTask(task: TaskEntity) {
//        DispatchQueue.global().async {
//            CoreDataManager.shared.context.delete(task)
//            CoreDataManager.shared.saveContext()
//            self.fetchTasks()
//        }
//    }
//
//    // Метод для обновления задачи
//    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
//        DispatchQueue.global().async {
//            task.title = title
//            task.taskDescription = taskDescription
//            task.isCompleted = isCompleted
//            CoreDataManager.shared.saveContext()
//            self.fetchTasks()
//        }
//    }
//    
//    // Получение данных из API
//    func fetchTasksFromAPI() {
//        TasksAPIService.shared.fetchTasks { [weak self] tasks in
//            guard let self = self, let tasks = tasks else { return }
//
//            // Сохранение в CoreData
//            self.saveTasksToCoreData(apiTasks: tasks)
//        }
//    }
//
//    // Сохранение данных из API в CoreData
//    private func saveTasksToCoreData(apiTasks: [ToDoItem]) {
//        apiTasks.forEach { apiTask in
//            let newTask = TaskEntity(context: CoreDataManager.shared.context)
//            newTask.apiId = Int32(apiTask.id)
//            newTask.title = apiTask.todo
//            newTask.isCompleted = apiTask.completed
//            newTask.createdAt = Date()
//
//            // Сохранение в CoreData
//            do {
//                try CoreDataManager.shared.context.save()
//                DispatchQueue.main.async {
//                    print("Tasks saved successfully!")
//                    self.presenter?.tasksFetchedSuccess(tasks: self.fetchTasksFromCoreData())
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    print("Failed to save tasks to CoreData: \(error)")
//                    self.presenter?.tasksFetchedFailed()
//                }
//            }
//        }
//    }
//}

//GIGA CHAT

import Foundation
import CoreData

class TasksInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchTasks() {
        let tasks = fetchTasksFromCoreData() // или fetchTasksFromAPI()
        presenter?.tasksFetchedSuccess(tasks: tasks)
    }
    
    // Добавление метода fetchTasksFromCoreData
    private func fetchTasksFromCoreData() -> [ToDoTaskEntity] {
        let fetchRequest: NSFetchRequest<ToDoTaskEntity> = ToDoTaskEntity.fetchRequest()
        do {
            let tasks = try CoreDataManager.shared.context.fetch(fetchRequest)
            return tasks
        } catch {
            print("Failed to fetch tasks from CoreData: \(error)")
            return []
        }
    }

    // Метод для добавления новой задачи
    func addTask(title: String, taskDescription: String) {
        DispatchQueue.main.async {
            let newTask = ToDoTaskEntity(context: CoreDataManager.shared.context)
            newTask.title = title
            newTask.taskDescription = taskDescription
            newTask.isCompleted = false
            newTask.createdAt = Date()

            CoreDataManager.shared.saveContext()
            
            self.fetchTasks()
        }
    }

    // Метод для удаления задачи
    func deleteTask(task: ToDoTaskEntity) {
        DispatchQueue.main.async {
            CoreDataManager.shared.context.delete(task)
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }

    // Метод для обновления задачи
    func updateTask(task: ToDoTaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
        DispatchQueue.main.async {
            task.title = title
            task.taskDescription = taskDescription
            task.isCompleted = isCompleted
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }
    
    // Получение данных из API
    func fetchTasksFromAPI() {
        TasksAPIService.shared.fetchTasks { [weak self] tasks in
            guard let self = self, let tasks = tasks else { return }

            // Сохранение в CoreData
            self.saveTasksToCoreData(apiTasks: tasks)
        }
    }

    // Сохранение данных из API в CoreData
    private func saveTasksToCoreData(apiTasks: [ToDoItem]) {
        apiTasks.forEach { apiTask in
            let newTask = ToDoTaskEntity(context: CoreDataManager.shared.context)
            newTask.apiId = Int32(apiTask.id)
            newTask.title = apiTask.todo
            newTask.isCompleted = apiTask.completed
            newTask.createdAt = Date()

            // Сохранение в CoreData
            do {
                try CoreDataManager.shared.context.save()
                DispatchQueue.main.async {
                    print("Tasks saved successfully!")
                    self.presenter?.tasksFetchedSuccess(tasks: self.fetchTasksFromCoreData())
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to save tasks to CoreData: \(error)")
                    self.presenter?.tasksFetchedFailed()
                }
            }
        }
    }
}
