//
//  TodoItem.Table.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import SQLite

struct TodoItemTable: SqliteTable {
    static let name = "todoItems"
    static let foreignKey = "todoListId"
    static let table = Table(name)
    static let id = Expression<String>(TodoItem.Keys.id)
    static let todoListId = Expression<String>(foreignKey)
    static let text = Expression<String>(TodoItem.Keys.text)
    static let priority = Expression<String>(TodoItem.Keys.priority)
    static let deadline = Expression<String?>(TodoItem.Keys.deadline)
    static let isDone = Expression<Bool>(TodoItem.Keys.isDone)
    static let createdOn = Expression<String>(TodoItem.Keys.createdOn)
    static let updatedOn = Expression<String>(TodoItem.Keys.updatedOn)
    
    static func getName() -> String {
        return name
    }
    
    static func createTable(dbConnection: SQLite.Connection?) throws {
        try dbConnection?.run(table.create { table in
            table.column(id, primaryKey: true)
            table.column(todoListId)
            table.column(text)
            table.column(priority)
            table.column(deadline)
            table.column(isDone)
            table.column(createdOn)
            table.column(updatedOn)
            table.foreignKey(todoListId, references: TodoListTable.table, TodoListTable.id)
        })
    }
}
