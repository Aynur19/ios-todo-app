//
//  TodoItem.ManagedObject.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.07.2023.
//

import Foundation
import CoreData

extension TodoItemManagedObject {
//    @NSManaged var id: String
//    @NSManaged var text: String
//    @NSManaged var priority: String
//    @NSManaged var deadline: Date?
//    @NSManaged var isDone: Bool
//    @NSManaged var createdOn: Date
//    @NSManaged var updatedOn: Date?
//
//    @NSManaged var todoListId: String
    
    func toItem() -> TodoItem? {
        guard let todoPriority = TodoItemPriority.init(rawValue: priority ?? ""),
              let id = id,
              let text = text,
              let color = color,
            let createdOn = createdOn,
              let updatedOn = updatedOn,
              let todoListId = todoListId
        else { return nil }
        
        return TodoItem(id: id, text: text, priority: todoPriority,
                        deadline: deadline, isDone: isDone,
                        createdOn: createdOn, updatedOn: updatedOn,
                        color: color, todoListId: todoListId)
    }
    
    static func fromItem(in context: NSManagedObjectContext, item: TodoItem) -> NSManagedObject? {
        let newItem = TodoItemManagedObject(context: context)
        newItem.id = item.id
        newItem.text = item.id
        newItem.priority = item.priority.rawValue
        newItem.deadline = item.deadline
        newItem.isDone = item.isDone
        newItem.createdOn = item.createdOn
        newItem.updatedOn = item.updatedOn
        newItem.color = item.color
        newItem.todoListId = item.todoListId
        
        return newItem
    }
}
