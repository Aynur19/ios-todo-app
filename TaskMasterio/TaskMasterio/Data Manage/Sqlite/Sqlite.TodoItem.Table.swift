//
//  Sqlite.TodoItem.Table.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import Foundation
import SQLite

struct TodoItemTable: SqliteTable {
    static let name = "todoItems"
    static let table = Table(name)
    
    static let id = Expression<String>(TodoItem.Keys.id)
    static let todoListId = Expression<String>(TodoItem.Keys.todoListId)
    static let text = Expression<String>(TodoItem.Keys.text)
    static let priority = Expression<String>(TodoItem.Keys.priority)
    static let deadline = Expression<String?>(TodoItem.Keys.deadline)
    static let isDone = Expression<Bool>(TodoItem.Keys.isDone)
    static let createdOn = Expression<String>(TodoItem.Keys.createdOn)
    static let updatedOn = Expression<String?>(TodoItem.Keys.updatedOn)
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
    
    static func select(by id: String) -> Table {
        return table.select(*).filter(self.id == id)
    }
    
    static func select(with todoListid: String) -> Table {
        return table.select(*).filter(self.todoListId == todoListid)
    }
    
    static func insert(_ item: TodoItem) -> Insert {
        let deadlineValue = item.deadline?.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        let createdOnValue = item.createdOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        let updatedOnValue = item.updatedOn?.toString(format: DatetimeFormats.yyyyMMddTHHmmss)
        
        let insertOperation = table.insert(
            id <- item.id,
            todoListId <- item.todoListId,
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
        
        let updateOperation = table.filter(id == item.id).update(
            text <- item.text,
            priority <- item.priority.rawValue,
            deadline <- deadlineValue,
            isDone <- item.isDone,
            updatedOn <- updatedOnValue,
            color <- item.color
        )
        
        return updateOperation
    }
    
    static func delete(by itemId: String) -> Delete {
        let deleteOperation = table.filter(id == itemId).delete()
        return deleteOperation
    }
    
    static func toDomain(rows: AnySequence<Row>) -> [TodoItem] {
        var items = [TodoItem]()
        
        for row in rows {
            if let item = toDomain(row: row) {
                items.append(item)
            }
        }
        
        return items
    }
    
    static func toDomain(row: Row) -> TodoItem? {
        var todoDeadline: Date?
        if let deadlineStr = row[deadline] {
            todoDeadline = Helper.stringToDate(dateStr: deadlineStr, dateFormat: DatetimeFormats.yyyyMMddTHHmmss)
        }
        
        var todoUpdatedOn: Date?
        if let updatedOnStr = row[deadline] {
            todoUpdatedOn = Helper.stringToDate(dateStr: updatedOnStr, dateFormat: DatetimeFormats.yyyyMMddTHHmmss)
        }
        
        let createdOnValue = Helper.stringToDate(dateStr: row[createdOn], dateFormat: DatetimeFormats.yyyyMMddTHHmmss)
        
        guard let todoCreatedOn = createdOnValue else {
            return nil
        }
        
        guard let todoPriority = TodoItemPriority.init(rawValue: row[priority]) else { return nil }
        
        let todoId = row[id]
        let todoText = row[text]
        let todoIsDone = row[isDone]
        let todoColor = row[color]
        let todoParentListId = row[todoListId]
        
        return TodoItem(id: todoId, text: todoText, priority: todoPriority,
                        deadline: todoDeadline, isDone: todoIsDone,
                        createdOn: todoCreatedOn, updatedOn: todoUpdatedOn,
                        color: todoColor, todoListId: todoParentListId)
    }
    
    static func getName() -> String {
        return name
    }
    
    static func getTable() -> Table {
        return table
    }
}
