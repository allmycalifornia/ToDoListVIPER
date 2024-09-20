//
//  TasksViewWrapper.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

struct TasksViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let swiftUIView = TasksRouter.createTasksModule()
        return UIHostingController(rootView: swiftUIView)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
