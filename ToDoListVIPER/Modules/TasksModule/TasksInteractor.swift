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
    
    // Получение задач из CoreData
    func fetchTasks() {
        DispatchQueue.global().async {
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            do {
                let tasks = try CoreDataManager.shared.context.fetch(fetchRequest)
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchedSuccess(tasks: tasks)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchedFailed()
                }
            }
        }
    }

    // Добавление новой задачи
    func addTask(title: String, taskDescription: String) {
        DispatchQueue.global().async {
            let newTask = TaskEntity(context: CoreDataManager.shared.context)
            newTask.title = title
            newTask.taskDescription = taskDescription
            newTask.isCompleted = false
            newTask.createdAt = Date()

            CoreDataManager.shared.saveContext()
            
            self.fetchTasks()
        }
    }

    // Удаление задачи
    func deleteTask(task: TaskEntity) {
        DispatchQueue.global().async {
            CoreDataManager.shared.context.delete(task)
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }

    // Обновление задачи
    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
        DispatchQueue.global().async {
            task.title = title
            task.taskDescription = taskDescription
            task.isCompleted = isCompleted
            CoreDataManager.shared.saveContext()
            self.fetchTasks()
        }
    }
}
