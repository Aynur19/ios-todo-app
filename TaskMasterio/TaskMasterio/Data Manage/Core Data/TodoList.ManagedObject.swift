//
//  TodoList.ManagedObject.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.07.2023.
//

//import Foundation
import CoreData

//@objc(TodoListManagedObject)
extension TodoListManagedObject {
//    @NSManaged var id: String
//    @NSManaged var revision: Int
//    @NSManaged var isDirty: Bool
//    @NSManaged var lastUpdatedBy: String
//    @NSManaged var lastUpdatedOn: Date
    
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListManagedObject> {
//        return NSFetchRequest<TodoListManagedObject>(entityName: "TodoListManagedObject")
//    }
    
    func toTodoList() -> TodoList? {
        guard let id = id,
              let lastUpdatedBy = lastUpdatedBy,
              let lastUpdatedOn = lastUpdatedOn
        else {
            return nil
        }
        return TodoList(id: id, revision: Int(revision), isDirty: isDirty, lastUpdatedBy: lastUpdatedBy, lastUpdatedOn: lastUpdatedOn)
    }
    
    static func fromItem(in context: NSManagedObjectContext, item: TodoList) -> TodoListManagedObject {
        let newList = TodoListManagedObject(context: context)
        newList.id = item.id
        newList.revision = Int64(item.revision)
        newList.isDirty = item.isDirty
        newList.lastUpdatedBy = item.lastUpdatedBy
        newList.lastUpdatedOn = item.lastUpdatedOn
        
        return newList
    }
}
