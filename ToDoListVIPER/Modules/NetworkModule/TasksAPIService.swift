//
//  TasksAPIService.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 18.09.2024.
//

//import Foundation
//
//struct ToDoItem: Decodable {
//    let id: Int
//    let todo: String
//    let completed: Bool
//    let userId: Int
//}
//
//class TasksAPIService {
//    static let shared = TasksAPIService()
//
//    private let apiURL = "https://dummyjson.com/todos"
//
//    func fetchTasks(completion: @escaping ([ToDoItem]?) -> Void) {
//        guard let url = URL(string: apiURL) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching tasks: \(error)")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                print("No data returned")
//                completion(nil)
//                return
//            }
//
//            do {
//                let tasks = try JSONDecoder().decode([ToDoItem].self, from: data)
//                completion(tasks)
//            } catch {
//                print("Error decoding data: \(error)")
//                completion(nil)
//            }
//        }.resume()
//    }
//}

import Foundation

class TasksAPIService {
    static let shared = TasksAPIService()
    
    private init() {}
    
    func fetchTasks(completion: @escaping ([ToDoItem]?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching tasks: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([ToDoItem].self, from: data)
                print("Fetched tasks from API: \(decodedData)")
                completion(decodedData)
            } catch {
                print("Failed to decode tasks: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
    
struct ToDoResponse: Codable {
    let todos: [ToDoItem]
}

struct ToDoItem: Codable {
    let id: Int
    let todo: String
    let completed: Bool
}
