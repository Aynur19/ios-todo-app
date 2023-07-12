//
//  TodoList.Table.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import SQLite

struct TodoListTable: SqliteTable {
    static let name = "todoLists"
    static let table = Table(name)
    static let id = Expression<String>(TodoList.Keys.id)
    static let revision = Expression<String>(TodoList.Keys.revision)
    static let isDirty = Expression<String>(TodoList.Keys.isDirty)
    static let lastUpdatedOn = Expression<String>(TodoList.Keys.lastUpdatedOn)
    static let lastUpdatedBy = Expression<String>(TodoList.Keys.lastUpdatedBy)
    
    static func createTable(dbConnection: Connection?) throws {
        try dbConnection?.run(table.create { table in
            table.column(id, primaryKey: true)
            table.column(revision)
            table.column(isDirty)
            table.column(lastUpdatedOn)
            table.column(lastUpdatedBy)
        })
    }
    
    static func getName() -> String {
        return name
    }
}
