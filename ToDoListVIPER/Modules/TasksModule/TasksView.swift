//
//  TasksView.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

//import SwiftUI
//
//struct TasksView: View {
//    @StateObject var presenter = TasksPresenter()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(presenter.tasks) { task in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(task.title ?? "No Title")
//                                    .font(.headline)
//                                Text(task.taskDescription ?? "No Description")
//                                    .font(.subheadline)
//                            }
//                            Spacer()
//                            if task.isCompleted {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .foregroundColor(.green)
//                            } else {
//                                Image(systemName: "circle")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                    }
//                    .onDelete(perform: deleteTask)
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle("Tasks")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        // Действие для добавления новой задачи
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .onAppear {
//                presenter.startFetchingTasks()
//            }
//        }
//    }
//    
//    func deleteTask(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let task = presenter.tasks[index]
//            presenter.deleteTask(task: task)
//        }
//    }
//}
//

//import SwiftUI
//
//struct TasksView: View {
//    @StateObject var presenter = TasksPresenter()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(presenter.tasks, id: \.self) { task in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(task.title ?? "No Title")
//                                    .font(.headline)
//                                Text(task.taskDescription ?? "No Description")
//                                    .font(.subheadline)
//                            }
//                            Spacer()
//                            if task.isCompleted {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .foregroundColor(.green)
//                            } else {
//                                Image(systemName: "circle")
//                                    .foregroundColor(.red)
//                            }
//                        }
//                    }
//                    .onDelete(perform: deleteTask)
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle("Tasks")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        // Добавление новой задачи
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .onAppear {
//                presenter.startFetchingTasks()
//            }
//        }
//    }
//    
//    func deleteTask(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let task = presenter.tasks[index]
//            presenter.deleteTask(task: task)
//        }
//    }
//}

import SwiftUI

struct TasksView: View {
    @StateObject var presenter = TasksPresenter()
    
    // Переменные для нового задания
    @State private var newTaskTitle: String = ""
    @State private var newTaskDescription: String = ""
    @State private var showingAddTaskSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(presenter.tasks, id: \.self) { task in
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
                        showingAddTaskSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTaskSheet) {
                VStack {
                    TextField("Task Title", text: $newTaskTitle)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Task Description", text: $newTaskDescription)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    Button(action: {
                        addTask()
                        showingAddTaskSheet.toggle()
                    }) {
                        Text("Add Task")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .onAppear {
                presenter.startFetchingTasks()
            }
        }
    }
    
    // Функция для удаления задач
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = presenter.tasks[index]
            presenter.deleteTask(task: task)
        }
    }

    // Функция для добавления новой задачи
    func addTask() {
        guard !newTaskTitle.isEmpty, !newTaskDescription.isEmpty else { return }
        presenter.addTask(title: newTaskTitle, taskDescription: newTaskDescription)
        newTaskTitle = ""
        newTaskDescription = ""
    }
}
