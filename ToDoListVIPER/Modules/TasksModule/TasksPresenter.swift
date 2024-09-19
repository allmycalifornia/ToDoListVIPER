//
//  TasksPresenter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

//import Foundation
//
//class TasksPresenter: ObservableObject, ViewToPresenterProtocol {
//    @Published var tasks: [TaskEntity] = []
//
//    var view: PresenterToViewProtocol?
//    var interactor: PresenterToInteractorProtocol?
//    var router: PresenterToRouterProtocol?
//    
//    func startFetchingTasks() {
//        interactor?.fetchTasks()
//        interactor?.fetchTasksFromAPI()
//    }
//
//    func addTask(title: String, taskDescription: String) {
//        interactor?.addTask(title: title, taskDescription: taskDescription)
//    }
//
//    func deleteTask(task: TaskEntity) {
//        interactor?.deleteTask(task: task)
//    }
//
//    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
//        interactor?.updateTask(task: task, title: title, taskDescription: taskDescription, isCompleted: isCompleted)
//    }
//}
//
//// Расширение для реализации методов протокола InteractorToPresenterProtocol
//extension TasksPresenter: InteractorToPresenterProtocol {
//    func tasksFetchedSuccess(tasks: [TaskEntity]) {
//        view?.showTasks(tasks: tasks)
//    }
//
//    func tasksFetchedFailed() {
//        view?.showError()
//    }
//}

//import Foundation
//
//class TasksPresenter: ViewToPresenterProtocol {
//    var view: PresenterToViewProtocol?
//    var interactor: PresenterToInteractorProtocol?
//    var router: PresenterToRouterProtocol?
//
//    func startFetchingTasks() {
//        // Либо загружаем данные из CoreData, либо из API
//        interactor?.fetchTasksFromAPI()
//    }
//    
//    func addTask(title: String, taskDescription: String) {
//        interactor?.addTask(title: title, taskDescription: taskDescription)
//    }
//
//    func deleteTask(task: TaskEntity) {
//        interactor?.deleteTask(task: task)
//    }
//
//    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
//        interactor?.updateTask(task: task, title: title, taskDescription: taskDescription, isCompleted: isCompleted)
//    }
//}

//import Foundation
//
//class TasksPresenter: ObservableObject, ViewToPresenterProtocol {
//    @Published var tasks: [TaskEntity] = [] {
//        didSet {
//            view?.showTasks(tasks: tasks)
//        }
//    }
//    
//    weak var view: PresenterToViewProtocol?
//    var interactor: PresenterToInteractorProtocol?
//    var router: PresenterToRouterProtocol?
//    
//    // Запуск получения задач
//    func startFetchingTasks() {
//        interactor?.fetchTasks()
//    }
//    
//    // Добавление новой задачи
//    func addTask(title: String, taskDescription: String) {
//        interactor?.addTask(title: title, taskDescription: taskDescription)
//    }
//    
//    // Удаление задачи
//    func deleteTask(task: TaskEntity) {
//        interactor?.deleteTask(task: task)
//    }
//    
//    // Обновление задачи
//    func updateTask(task: TaskEntity, title: String, taskDescription: String, isCompleted: Bool) {
//        interactor?.updateTask(task: task, title: title, taskDescription: taskDescription, isCompleted: isCompleted)
//    }
//    
//    // Загрузка задач из API
//    func fetchTasksFromAPI() {
//        interactor?.fetchTasksFromAPI()
//    }
//}
//
//// Реализация методов получения данных от Interactor
//extension TasksPresenter: InteractorToPresenterProtocol {
//    func tasksFetchedSuccess(tasks: [TaskEntity]) {
//        print("Presenter received tasks: \(tasks.count)")
//        DispatchQueue.main.async {
//            self.view?.showTasks(tasks: tasks)
//        }
//    }
//
//    func tasksFetchedFailed() {
//        view?.showError()
//    }
//}

//import Foundation
//
//class TasksPresenter: ObservableObject {
//    @Published var tasks: [TaskEntity] = [] // Обновляем массив задач
//    
//    var interactor: PresenterToInteractorProtocol?
//    var router: PresenterToRouterProtocol?
//
//    func startFetchingTasks() {
//        interactor?.fetchTasks()
//    }
//
//    func addTask(title: String, taskDescription: String) {
//        interactor?.addTask(title: title, taskDescription: taskDescription)
//    }
//
//    func deleteTask(task: TaskEntity) {
//        interactor?.deleteTask(task: task)
//    }
//}
//
//extension TasksPresenter: InteractorToPresenterProtocol {
//    func tasksFetchedSuccess(tasks: [TaskEntity]) {
//        DispatchQueue.main.async {
//            self.tasks = tasks // Обновляем задачи в главном потоке
//            print("Presenter received tasks: \(tasks.count)")
//        }
//    }
//
//    func tasksFetchedFailed() {
//        print("Failed to fetch tasks")
//    }
//}

//GIGA CHAT

import Foundation

class TasksPresenter: ObservableObject {
    @Published var tasks: [ToDoTaskEntity] = [] // Обновляем массив задач
    
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
}

extension TasksPresenter: InteractorToPresenterProtocol {
    func tasksFetchedSuccess(tasks: [ToDoTaskEntity]) {
        DispatchQueue.main.async {
            self.tasks = tasks // Обновляем задачи в главном потоке
            print("Presenter received tasks: \(tasks.count)")
        }
    }

    func tasksFetchedFailed() {
        print("Failed to fetch tasks")
    }
}
