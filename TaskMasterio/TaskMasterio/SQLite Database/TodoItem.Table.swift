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
    static let color = Expression<String>(TodoItem.Keys.color)
    
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
            table.column(color)
            table.foreignKey(todoListId, references: TodoListTable.table, TodoListTable.id)
        })
    }
    
    static func insert(_ item: TodoItem, foreingKeys: [String: String]) -> Insert? {
        guard let fkValue = foreingKeys[foreignKey] else {
            print("Ошибка добавления записи: Не найден внешний ключ!")
            return nil
        }
        
        let deadlineValue = item.deadline?.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        let createdOnValue = item.createdOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        let updatedOnValue = item.updatedOn?.toString(format: DatetimeFormats.yyyyMMddTHHmmss) ?? createdOnValue
        
        let insertOperation = table.insert(
            id <- item.id,
            todoListId <- fkValue,
            text <- item.text,
            priority <- item.priority.rawValue,
            deadline <- deadlineValue,
            isDone <- item.isDone,
            createdOn <- createdOnValue,
            updatedOn <- updatedOnValue,
            color <- item.color
        )
        
        return insertOperation
    }
    
    static func update(_ item: TodoItem) -> Update {
        let deadlineValue = item.deadline?.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        let updatedOnValue = (item.updatedOn ?? item.createdOn).toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        
        let updateOperation = table.update(
            text <- item.text,
            priority <- item.priority.rawValue,
            deadline <- deadlineValue,
            isDone <- item.isDone,
            updatedOn <- updatedOnValue,
            color <- item.color
        )
        
        return updateOperation
    }
    
    static func getName() -> String {
        return name
    }
    
    static func getTable() -> Table {
        return table
    }
}
