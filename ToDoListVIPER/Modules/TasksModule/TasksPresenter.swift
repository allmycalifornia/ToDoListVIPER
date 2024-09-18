//
//  TasksPresenter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation

class TasksPresenter: ObservableObject, ViewToPresenterProtocol {
    @Published var tasks: [TaskEntity] = []

    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    func startFetchingTasks() {
        interactor?.fetchTasks()
    }

    func addTask(title: String, taskDescription: String) {
        interactor?.addTask(title: title, taskDescription: taskDescription)
    }

    func deleteTask(task: TaskEntity) {
        interactor?.deleteTask(task: task)
    }

    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
        interactor?.updateTask(task: task, title: title, taskDescription: taskDescription, isCompleted: isCompleted)
    }
}

// Расширение для реализации методов протокола InteractorToPresenterProtocol
extension TasksPresenter: InteractorToPresenterProtocol {
    func tasksFetchedSuccess(tasks: [TaskEntity]) {
        DispatchQueue.main.async {
            self.tasks = tasks
        }
    }

    func tasksFetchedFailed() {
        DispatchQueue.main.async {
            self.tasks = []
            // Возможно, обработка ошибки
        }
    }
}
