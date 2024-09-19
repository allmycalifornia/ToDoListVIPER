//
//  ToDoTaskEntity+CoreDataProperties.swift
//  ToDoListVIPER
//
//  Created by Борис Кравченко on 18.09.2024.
//
//

import Foundation
import CoreData

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "ToDoTaskEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var apiId: Int32

}
