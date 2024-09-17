//
//  TasksInteractor.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation

protocol TasksInteractorProtocol: AnyObject {
    func loadTasks()
}

class TasksInteractor: TasksInteractorProtocol {
    var presenter: TasksPresenterProtocol?

    func loadTasks() {
        // Здесь будет логика загрузки задач
    }
}
