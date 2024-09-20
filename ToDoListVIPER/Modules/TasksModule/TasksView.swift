//
//  TasksView.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 17.09.2024.
//

import SwiftUI

struct TasksView: View {
    @StateObject var presenter = TasksPresenter()
    
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
                                if let createdAt = task.createdAt {
                                    Text("Created at: \(formatDate(createdAt))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            Button(action: {
                                toggleTaskCompletion(task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .red)
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
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = presenter.tasks[index]
            presenter.deleteTask(task: task)
        }
    }

    func addTask() {
        guard !newTaskTitle.isEmpty, !newTaskDescription.isEmpty else { return }
        presenter.addTask(title: newTaskTitle, taskDescription: newTaskDescription)
        newTaskTitle = ""
        newTaskDescription = ""
    }
    
    func toggleTaskCompletion(_ task: ToDoTaskEntity) {
        presenter.updateTask(task: task, title: task.title ?? "", taskDescription: task.taskDescription ?? "", isCompleted: !task.isCompleted)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
