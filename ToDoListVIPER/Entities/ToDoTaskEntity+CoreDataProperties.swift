//
//  ToDoTaskEntity+CoreDataProperties.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 19.09.2024.
//
//

import Foundation
import CoreData


extension ToDoTaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTaskEntity> {
        return NSFetchRequest<ToDoTaskEntity>(entityName: "ToDoTaskEntity")
    }

    @NSManaged public var apiId: Int32
    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?

}

extension ToDoTaskEntity : Identifiable {

}
