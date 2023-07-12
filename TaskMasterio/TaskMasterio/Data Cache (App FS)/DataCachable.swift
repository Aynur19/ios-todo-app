//
//  DataCachable.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

enum DataStoreType: String {
    case json
    case csv
    case rest
    case sql
    case coreData
}

protocol DataCachable {
    var context: TodoList { get }
    
    func configure(name: String, connectionUrl: URL?)
    
    func updateMetadata(revision: Int, isDurty: Bool, lastUpdatedBy: String, lastUpdatedOn: Int)
    
    func load() -> Result<Void, Error>
    
    func clearContext()
    
    func get(by id: String) -> TodoItem?
    
    // возвращает дубликат (по ID)
    func insert(_ item: TodoItem) -> TodoItem?
    
    // возвращает обновленный элемент (до обновления)
    func update(_ item: TodoItem) -> TodoItem?
    
    // возвращает обновленный элемент (до обновления)
    func insertOrUpdate(_ item: TodoItem) -> TodoItem?
    
    // возвращает удаленный элемент
    func delete(by id: String) -> TodoItem?
    
    func save() -> Result<Void, Error>
}
