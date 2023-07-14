//
//  SqliteTodoListRepository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation
import SQLite

class SqliteTodoListRepository: TodoListRepository, SqliteRepository {
    typealias Entity = TodoList

    private(set) var inserts = [Insert]()
    private(set) var updates = [Update]()
    private(set) var deletes = [Delete]()
    
    func clearInserts() { inserts.removeAll() }
    func clearUpdates() { updates.removeAll() }
    func clearDeletes() { deletes.removeAll() }
    
    override func insert(_ entity: Entity) -> Entity? {
        if let foundedItem = super.insert(entity) {
            return foundedItem
        }
        
        if let insert = TodoListTable.insert(entity, foreingKeys: [:]) {
            inserts.append(insert)
        }
        
        return nil
    }
    
    override func update(_ entity: Entity) -> Entity? {
        guard let updatedItem = super.update(entity) else { return nil }
    
        updates.append(TodoListTable.update(entity))
        return updatedItem
    }
    
    override func upsert(_ entity: Entity) -> Entity? {
        if let updatedItem = update(entity) {
            return updatedItem
        }
        
        return insert(entity)
    }
    
    override func delete(by id: String) -> Entity? {
        guard let deletedItem = super.delete(by: id) else { return nil }
        deletes.append(TodoListTable.delete(by: id))
        
        return deletedItem
    }
}
