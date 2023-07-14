//
//  BaseRepository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

class TodoListRepository: BaseRepository<TodoList> { }

class TodoItemRepository: BaseRepository<TodoItem> { }

class BaseRepository<Entity: StringIdentifiable> {
    private(set) var dataset: [Entity]
    
    init(dataset: [Entity]) {
        self.dataset = dataset
    }
    
    func get(by id: String) -> Entity? {
        return dataset.first { $0.id == id }
    }
    
    func getAll() -> [Entity] {
        return dataset
    }
    
    func insert(_ entity: Entity) -> Entity? {
        if let foundedItem = get(by: entity.id) {
            return foundedItem
        }
        dataset.append(entity)
        
        return nil
    }
    
    func update(_ entity: Entity) -> Entity? {
        var updatedItem: Entity?
        if let idx = dataset.firstIndex(where: { $0.id == entity.id }) {
            updatedItem = dataset[idx]
            dataset[idx] = entity
        }
        
        return updatedItem
    }
    
    func upsert(_ entity: Entity) -> Entity? {
        if let updatedItem = update(entity) {
            return updatedItem
        }
        dataset.append(entity)
        
        return nil
    }
    
    func delete(by id: String) -> Entity? {
        var deletedItem: Entity?
        if let idx = dataset.firstIndex(where: { $0.id == id }) {
            deletedItem = dataset[idx]
            dataset.remove(at: idx)
        }
        
        return deletedItem
    }
}
