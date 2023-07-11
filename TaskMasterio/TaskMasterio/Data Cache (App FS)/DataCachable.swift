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
    
    func configure(name: String, connectionUrl: URL?) throws
    
    func updateMetadata(revision: Int, isDurty: Bool, lastUpdatedBy: String, lastUpdatedOn: Int)
    
    func load() -> Result<Void, Error>
    
    func get(by id: String) -> TodoItem?
    
    func insert(_ item: TodoItem) -> TodoItem?
    
    func update(_ item: TodoItem) -> TodoItem?
    
    func insertOrUpdate(_ item: TodoItem) -> TodoItem?
    
    func delete(by id: String) -> TodoItem?
    
    func save() -> Result<Void, Error>
}
