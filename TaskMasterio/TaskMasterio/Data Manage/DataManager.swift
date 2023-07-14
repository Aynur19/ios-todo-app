//
//  DataManager.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

final class DataManager {
    private var unitOfWork: any UnitOfWork
    
    init(unitOfWork: any UnitOfWork) {
        self.unitOfWork = unitOfWork
    }
    
    func setUnitOfWork(unitOfWork: any UnitOfWork) {
        self.unitOfWork = unitOfWork
    }
    
    func configure(name: String, connectionUrl: URL?) {
        unitOfWork.configure(name: name, connectionUrl: connectionUrl)
    }
    
    func get(by id: String) -> TodoList? {
        return unitOfWork.todoLisrRepo.get(by: id)
    }
    
    
    func getAll() -> [TodoList] {
        return unitOfWork.todoLisrRepo.getAll()
    }
    
    func insert(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoLisrRepo.insert(entity)
    }
    
    func update(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoLisrRepo.update(entity)
    }
    
    func upsert(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoLisrRepo.upsert(entity)
    }
    
    func delete(by id: String) -> TodoList? {
        return unitOfWork.todoLisrRepo.delete(by: id)
    }
    
    func getItem(by id: String) -> TodoItem? { return nil }
    func getItems(typeOf: TodoItem.Type) -> [TodoItem] { return [] }
    func insertItem(_ entity: TodoItem) -> TodoItem? { return nil }
    func updateItem(_ entity: TodoItem) -> TodoItem? { return nil }
    func upsertItem(_ entity: TodoItem) -> TodoItem? { return nil }
    func deleteItem(by id: String) -> TodoItem? { return nil }

    func load() -> Result<Void, Error> {
        return unitOfWork.load()
    }
    
    func save() -> Result<Void, Error> {
        return unitOfWork.save()
    }
}
