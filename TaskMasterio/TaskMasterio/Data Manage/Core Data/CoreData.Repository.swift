//
//  CoreDataRepository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.07.2023.
//

import Foundation
import CoreData

final class TodoListCoreDataRepository: Repository {
    typealias Entity = TodoList
    
    private let mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext,
         backgroundContext: NSManagedObjectContext
    ) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
    
    func get(by id: String) -> Entity? {
        let fetchRequest: NSFetchRequest<TodoListManagedObject> =  NSFetchRequest<TodoListManagedObject>(entityName: "TodoListEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        
        do {
            let todoLists = try mainContext.fetch(fetchRequest)
            return todoLists.first?.toTodoList()
        } catch {
            print("Failed to fetch TodoList with id \(id): \(error)")
            return nil
        }
    }
    
    func getAll() -> [Entity] {
        let fetchRequest = TodoListManagedObject.fetchRequest()
        
        //        let fetchRequest: NSFetchRequest<TodoListManagedObject> = TodoListManagedObject.fetchRequest()
        
        var result = [TodoList]()
        //        let fetchRequest = TodoListManagedObject.fetchRequest()
        do {
            let todoLists = try mainContext.fetch(fetchRequest)
            
            result.append(contentsOf: todoLists.compactMap({ $0.toTodoList() }))
            //            return todoLists
        } catch {
            print("Failed to fetch TodoLists: \(error)")
            //            return nil
        }
        return result
        
    }
    
    func insert(_ entity: Entity) -> Entity? {
        let todoList = TodoListManagedObject.fromItem(in: backgroundContext, item: entity)
        do {
            try backgroundContext.save()
        } catch {
            print("Failed to save TodoList: \(error)")
        }
        return nil
    }
    //
    func update(_ entity: Entity) -> Entity? {
        //        var updatedItem: Entity?
        //        if let idx = context.context.firstIndex(where: { $0.id == entity.id }) {
        //            updatedItem = context.context[idx]
        //            context.context[idx] = entity
        //        }
        //
        //        return updatedItem
        return nil
    }
    //
    func upsert(_ entity: Entity) -> Entity? {
        
        //        if let updatedItem = update(entity) {
        //            return updatedItem
        //        }
        //        context.context.append(entity)
        //
        return nil
    }
    //
    func delete(by id: String) -> Entity? {
        //        var deletedItem: Entity?
        //        if let idx = context.context.firstIndex(where: { $0.id == id }) {
        //            deletedItem = context.context[idx]
        //            context.context.remove(at: idx)
        //        }
        //
        //        return deletedItem
        return nil
    }
    //
    //    func insert(_ entity: TodoList) -> TodoList {
    //        let newList = TodoListManagedObject(context: context)
    //        newList.name = name
    //        return newList
    //        if let foundedItem = super.insert(entity) {
    //            return foundedItem
    //        }
    //
    //
    //
    //        //        inserts.append(TodoListTable.insert(entity))
    //        return nil
    //    }
    //
    //    override func update(_ entity: Entity) -> Entity? {
    //        guard let updatedItem = super.update(entity) else { return nil }
    //
    //        //        updates.append(TodoListTable.update(entity))
    //        return updatedItem
    //    }
    //
    //    override func upsert(_ entity: Entity) -> Entity? {
    //        if let updatedItem = update(entity) {
    //            return updatedItem
    //        }
    //
    //        return insert(entity)
    //    }
    //
    //    override func delete(by id: String) -> Entity? {
    //        guard let deletedItem = super.delete(by: id) else { return nil }
    //        //        deletes.append(TodoListTable.delete(by: id))
    //
    //        return deletedItem
    //    }
}

final class TodoItemCoreDataRepository: Repository {
    typealias Entity = TodoItem
    
    private let mainContext: NSManagedObjectContext
    private let backgroundContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext,
         backgroundContext: NSManagedObjectContext
    ) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
    
    func get(by id: String) -> Entity? {
        let fetchRequest: NSFetchRequest<TodoItemManagedObject> =  NSFetchRequest<TodoItemManagedObject>(entityName: "TodoList")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        
        do {
            let todoLists = try mainContext.fetch(fetchRequest)
            return todoLists.first?.toItem()
        } catch {
            print("Failed to fetch TodoList with id \(id): \(error)")
            return nil
        }
    }
    
    func getAll() -> [Entity] {
        let fetchRequest: NSFetchRequest<TodoItemManagedObject> = NSFetchRequest<TodoItemManagedObject>(entityName: "TodoList")
        
        //        let fetchRequest: NSFetchRequest<TodoListManagedObject> = TodoListManagedObject.fetchRequest()
        
        var result = [TodoItem]()
        //        let fetchRequest = TodoListManagedObject.fetchRequest()
        do {
            let todoLists = try mainContext.fetch(fetchRequest)
            
            result.append(contentsOf: todoLists.compactMap({ $0.toItem() }))
            //            return todoLists
        } catch {
            print("Failed to fetch TodoLists: \(error)")
            //            return nil
        }
        return result
        
    }
    
    func insert(_ entity: Entity) -> Entity? {
        //        if let foundedItem = get(by: entity.id) {
        //            return foundedItem
        //        }
        //        context.context.append(entity)
        //
        return nil
    }
    //
    func update(_ entity: Entity) -> Entity? {
        //        var updatedItem: Entity?
        //        if let idx = context.context.firstIndex(where: { $0.id == entity.id }) {
        //            updatedItem = context.context[idx]
        //            context.context[idx] = entity
        //        }
        //
        //        return updatedItem
        return nil
    }
    //
    func upsert(_ entity: Entity) -> Entity? {
        //        if let updatedItem = update(entity) {
        //            return updatedItem
        //        }
        //        context.context.append(entity)
        //
        return nil
    }
    //
    func delete(by id: String) -> Entity? {
        //        var deletedItem: Entity?
        //        if let idx = context.context.firstIndex(where: { $0.id == id }) {
        //            deletedItem = context.context[idx]
        //            context.context.remove(at: idx)
        //        }
        //
        //        return deletedItem
        return nil
    }
    //
    //    func insert(_ entity: TodoList) -> TodoList {
    //        let newList = TodoListManagedObject(context: context)
    //        newList.name = name
    //        return newList
    //        if let foundedItem = super.insert(entity) {
    //            return foundedItem
    //        }
    //
    //
    //
    //        //        inserts.append(TodoListTable.insert(entity))
    //        return nil
    //    }
    //
    //    override func update(_ entity: Entity) -> Entity? {
    //        guard let updatedItem = super.update(entity) else { return nil }
    //
    //        //        updates.append(TodoListTable.update(entity))
    //        return updatedItem
    //    }
    //
    //    override func upsert(_ entity: Entity) -> Entity? {
    //        if let updatedItem = update(entity) {
    //            return updatedItem
    //        }
    //
    //        return insert(entity)
    //    }
    //
    //    override func delete(by id: String) -> Entity? {
    //        guard let deletedItem = super.delete(by: id) else { return nil }
    //        //        deletes.append(TodoListTable.delete(by: id))
    //
    //        return deletedItem
    //    }
}

