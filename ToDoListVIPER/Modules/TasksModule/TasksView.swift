//
//  TasksView.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import UIKit

protocol TasksViewProtocol: AnyObject {
    func displayTasks(_ tasks: [TaskEntity])
}

class TasksView: UIViewController, TasksViewProtocol {
    var presenter: TasksPresenterProtocol!

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tasks"

        tableView.frame = view.bounds
        view.addSubview(tableView)

        presenter.viewDidLoad()
    }

    func displayTasks(_ tasks: [TaskEntity]) {
        // Тут мы будем отображать задачи в таблице
    }
}
