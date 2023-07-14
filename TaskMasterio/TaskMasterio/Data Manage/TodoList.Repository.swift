//
//  TodoList.Repository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

class TodoListRepository: Repository {
    typealias Entity = TodoList
    
    private(set) var context: TodoListContext

    init(context: TodoListContext) {
        self.context = context
    }
    
    func get(by id: String) -> Entity? {
        return context.context.first { $0.id == id }
    }
    
    func getAll() -> [Entity] {
        return context.context
    }
    
    func insert(_ entity: Entity) -> Entity? {
        if let foundedItem = get(by: entity.id) {
            return foundedItem
        }
        context.context.append(entity)
        
        return nil
    }
    
    func update(_ entity: Entity) -> Entity? {
        var updatedItem: Entity?
        if let idx = context.context.firstIndex(where: { $0.id == entity.id }) {
            updatedItem = context.context[idx]
            context.context[idx] = entity
        }
        
        return updatedItem
    }
    
    func upsert(_ entity: Entity) -> Entity? {
        if let updatedItem = update(entity) {
            return updatedItem
        }
        context.context.append(entity)
        
        return nil
    }
    
    func delete(by id: String) -> Entity? {
        var deletedItem: Entity?
        if let idx = context.context.firstIndex(where: { $0.id == id }) {
            deletedItem = context.context[idx]
            context.context.remove(at: idx)
        }
        
        return deletedItem
    }
}
