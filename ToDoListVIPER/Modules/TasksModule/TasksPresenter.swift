//
//  TasksPresenter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation

class TasksPresenter: ObservableObject {
    @Published var tasks: [ToDoTaskEntity] = []
    
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?

    func startFetchingTasks() {
        interactor?.fetchTasks()
    }

    func addTask(title: String, taskDescription: String) {
        interactor?.addTask(title: title, taskDescription: taskDescription)
    }

    func deleteTask(task: ToDoTaskEntity) {
        interactor?.deleteTask(task: task)
    }
    
    func updateTask(task: ToDoTaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
        interactor?.updateTask(task: task, title: title, taskDescription: taskDescription, isCompleted: isCompleted)
    }

}

extension TasksPresenter: InteractorToPresenterProtocol {
    func tasksFetchedSuccess(tasks: [ToDoTaskEntity]) {
        DispatchQueue.main.async {
            self.tasks = tasks
            print("Presenter received tasks: \(tasks.count)")
        }
    }

    func tasksFetchedFailed() {
        print("Failed to fetch tasks")
    }
}
