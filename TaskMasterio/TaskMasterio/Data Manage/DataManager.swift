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
    
    func configure(name: String, connectionUrl: URL? = nil) {
        unitOfWork.configure(name: name, connectionUrl: connectionUrl)
    }
    
    // MARK: TodoList
    func get(by id: String) -> TodoList? {
        return unitOfWork.todoListRepo.get(by: id)
    }
    
    func getAll() -> [TodoList] {
        return unitOfWork.todoListRepo.getAll()
    }
    
    func insert(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoListRepo.insert(entity)
    }
    
    func update(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoListRepo.update(entity)
    }
    
    func upsert(_ entity: TodoList) -> TodoList? {
        return unitOfWork.todoListRepo.upsert(entity)
    }
    
    func delete(by id: String) -> TodoList? {
        return unitOfWork.todoListRepo.delete(by: id)
    }
    
    // MARK: - TodoItem
    func getItem(by id: String) -> TodoItem? {
        return unitOfWork.todoItemRepo.get(by: id)
    }
    
    func getItems() -> [TodoItem] {
        return unitOfWork.todoItemRepo.getAll()
    }
    
    func insertItem(_ entity: TodoItem) -> TodoItem? {
        return unitOfWork.todoItemRepo.insert(entity)
    }
    
    func updateItem(_ entity: TodoItem) -> TodoItem? {
        return unitOfWork.todoItemRepo.update(entity)
    }
    
    func upsertItem(_ entity: TodoItem) -> TodoItem? {
        return unitOfWork.todoItemRepo.upsert(entity)
    }
    
    func deleteItem(by id: String) -> TodoItem? {
        return unitOfWork.todoItemRepo.delete(by: id)
    }

    // MARK: Load & Save
    func load() -> Result<Void, Error> {
        return unitOfWork.load(with: nil)
    }
    
    func load(with primaryKey: String? = nil) -> Result<Void, Error> {
        return unitOfWork.load(with: primaryKey)
    }
    
    func save() -> Result<Void, Error> {
        return unitOfWork.save()
    }
}
