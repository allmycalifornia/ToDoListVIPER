//
//  TasksViewWrapper.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

struct TasksViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Оборачиваем SwiftUI View в UIHostingController
        let swiftUIView = TasksRouter.createTasksModule() // VIPER-модуль, который возвращает some View
        return UIHostingController(rootView: swiftUIView) // Обернули в UIHostingController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Ничего не нужно обновлять
    }
}
