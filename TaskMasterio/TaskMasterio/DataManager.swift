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
    
    func get(by id: String) -> TodoList? { return nil }
    func getAll(typeOf: TodoList.Type) -> [TodoList] {
        unitOfWork.load()
        return unitOfWork.repo.getAll()
    }
    
    func insert(_ entity: TodoList) -> TodoList? {
        unitOfWork.repo.insert(entity)
    }
    
    func update(_ entity: TodoList) -> TodoList? { return nil }
    func upsert(_ entity: TodoList) -> TodoList? { return nil }
    func delete(by id: String) -> TodoList? { return nil }
    
    func get(by id: String) -> TodoItem? { return nil }
    func getAll(typeOf: TodoItem.Type) -> [TodoItem] { return [] }
    func insert(_ entity: TodoItem) -> TodoItem? { return nil }
    func update(_ entity: TodoItem) -> TodoItem? { return nil }
    func upsert(_ entity: TodoItem) -> TodoItem? { return nil }
    func delete(by id: String) -> TodoItem? { return nil }

    func save() -> Result<Void, Error>
    {
        return unitOfWork.save()
    }
}
