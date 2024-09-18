//
//  TasksView.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

struct TasksView: View {
    @StateObject var presenter = TasksPresenter()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(presenter.tasks) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title ?? "No Title")
                                    .font(.headline)
                                Text(task.taskDescription ?? "No Description")
                                    .font(.subheadline)
                            }
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Действие для добавления новой задачи
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                presenter.startFetchingTasks()
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = presenter.tasks[index]
            presenter.deleteTask(task: task)
        }
    }
}
