//
//  TasksViewWrapper.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

struct TasksViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return TasksRouter.createModule() // VIPER-модуль
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Ничего не нужно обновлять
    }
}
