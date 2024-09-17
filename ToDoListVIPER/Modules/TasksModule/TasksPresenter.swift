//
//  TasksPresenter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import Foundation

protocol TasksPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class TasksPresenter: TasksPresenterProtocol {
    weak var view: TasksViewProtocol?
    var interactor: TasksInteractorProtocol!
    var router: TasksRouterProtocol!

    func viewDidLoad() {
        interactor.loadTasks()
    }
}
