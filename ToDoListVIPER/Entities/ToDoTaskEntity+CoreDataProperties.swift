//
//  ToDoTaskEntity+CoreDataProperties.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 18.09.2024.
//
//

import Foundation
import CoreData

extension ToDoTaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "ToDoTaskEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?

}

extension ToDoTaskEntity : Identifiable {

}
