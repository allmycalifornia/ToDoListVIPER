//
//  TasksRouter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import UIKit

protocol TasksRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class TasksRouter: TasksRouterProtocol {
    static func createModule() -> UIViewController {
        let view = TasksView()
        let presenter = TasksPresenter()
        let interactor = TasksInteractor()
        let router = TasksRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
