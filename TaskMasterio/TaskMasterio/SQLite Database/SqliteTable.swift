//
//  SqliteTable.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import SQLite

protocol SqliteTable {
    associatedtype Entity
    
    static func getName() -> String
    static func getTable() -> Table
    
    static func createTable(dbConnection: Connection?) throws
    
    static func insert(_ item: Entity, foreingKeys: [String: String]) -> Insert?
    static func update(_ item: Entity) -> Update
    static func delete(by itemId: String) -> Delete
}
