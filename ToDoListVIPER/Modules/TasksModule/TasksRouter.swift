//
//  TasksRouter.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

class TasksRouter: PresenterToRouterProtocol {
    static func createTasksModule() -> some View {
        let presenter = TasksPresenter()
        let interactor = TasksInteractor()
        let router = TasksRouter()

        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return TasksView(presenter: presenter)
    }
}
