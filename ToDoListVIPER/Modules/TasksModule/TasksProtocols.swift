//
//  TasksProtocols.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func startFetchingTasks()
    func addTask(title: String, taskDescription: String)
    func deleteTask(task: ToDoTaskEntity)
    func updateTask(task: ToDoTaskEntity, title: String, taskDescription: String, isCompleted: Bool)
}

protocol PresenterToViewProtocol: AnyObject {
    func showTasks(tasks: [ToDoTaskEntity])
    func showError()
}

protocol PresenterToRouterProtocol: AnyObject {}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchTasks()
    func addTask(title: String, taskDescription: String)
    func deleteTask(task: ToDoTaskEntity)
    func updateTask(task: ToDoTaskEntity, title: String, taskDescription: String, isCompleted: Bool)
    func fetchTasksFromAPI()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func tasksFetchedSuccess(tasks: [ToDoTaskEntity])
    func tasksFetchedFailed()
}
