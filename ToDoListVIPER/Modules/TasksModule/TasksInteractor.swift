//
//  TasksInteractor.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation
import CoreData

class TasksInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchTasks() {
        fetchTasksFromAPI()
    }

    func fetchTasksFromAPI() {
        TasksAPIService.shared.fetchTasks { [weak self] tasks in
            guard let self = self else { return }
            
            if let tasks = tasks {
                self.saveTasksToCoreData(apiTasks: tasks)
            } else {
                let coreDataTasks = self.fetchTasksFromCoreData()
                self.presenter?.tasksFetchedSuccess(tasks: coreDataTasks)
            }
        }
    }
    
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

    func deleteTask(task: ToDoTaskEntity) {
        DispatchQueue.main.async {
            CoreDataManager.shared.context.delete(task)
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }

    func updateTask(task: ToDoTaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
        DispatchQueue.main.async {
            task.title = title
            task.taskDescription = taskDescription
            task.isCompleted = isCompleted
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }

    private func saveTasksToCoreData(apiTasks: [ToDoItem]) {
        apiTasks.forEach { apiTask in
            let newTask = ToDoTaskEntity(context: CoreDataManager.shared.context)
            newTask.apiId = Int32(apiTask.id)
            newTask.title = apiTask.todo
            newTask.isCompleted = apiTask.completed
            newTask.createdAt = Date()

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
