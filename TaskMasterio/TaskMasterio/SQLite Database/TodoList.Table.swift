//
//  TodoList.Table.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import Foundation
import SQLite
/*
class TodoListTable2: SqliteTable2 {
    typealias Entity = TodoList

    
    static func select(by id: String) -> SQLite.Select<SQLite.Table> {
        <#code#>
    }
    
    static let name = "todoLists"
    static let table = Table(name)
    
    static let id = Expression<String>(TodoList.Keys.id)
    static let revision = Expression<Int>(TodoList.Keys.revision)
    static let isDirty = Expression<Bool>(TodoList.Keys.isDirty)
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
    
    static func select(by id: String) -> Table {
        return table.select(*).filter(self.id == id)
    }
    
    static func insert(_ entity: TodoList, foreingKeys: [String : String]? = nil) -> Insert? {
        let insertOperation = table.insert(
            id <- entity.id,
            revision <- entity.revision,
            isDirty <- entity.isDirty,
            lastUpdatedOn <- entity.lastUpdatedOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss),
            lastUpdatedBy <- entity.lastUpdatedBy
        )
        
        return insertOperation
    }
    
    static func update(_ entity: TodoList) -> Update {
        let updateOperation = table.update(
            revision <- entity.revision,
            isDirty <- entity.isDirty,
            lastUpdatedOn <- entity.lastUpdatedOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss),
            lastUpdatedBy <- entity.lastUpdatedBy
        )
        
        return updateOperation
    }
    
    static func delete(by itemId: String) -> Delete {
        let deleteOperation = table.filter(id == itemId).delete()
        
        return deleteOperation
    }
    
    static func getName() -> String {
        return name
    }
    
    static func getTable() -> Table {
        return table
    }
    
    static func toDomain(rows: AnySequence<Row>) -> [TodoList] {
        var items = [TodoList]()
        
        for row in rows {
            if let item = toDomain(row: row) {
                items.append(item)
            }
        }
        
        return items
    }
    
    static func toDomain(row: Row) -> TodoList? {
        let datetime = Helper.stringToDate(dateStr: row[lastUpdatedOn], dateFormat: DatetimeFormats.yyyyMMddTHHmmss)
        guard let todoListLastUpdatedOn = datetime else { return nil }
        
        let todoListId = row[id]
        let todoListRevision = row[revision]
        let todoListIsDirty = row[isDirty]
        let todoListLastUpdatedBy = row[lastUpdatedBy]
        
        return TodoList(id: todoListId, revision: todoListRevision, isDirty: todoListIsDirty,
                        lastUpdatedBy: todoListLastUpdatedBy, lastUpdatedOn: todoListLastUpdatedOn)
    }
    
    
}
*/

struct TodoListTable: SqliteTable {
    static let name = "todoLists"
    static let table = Table(name)
    
    static let id = Expression<String>(TodoList.Keys.id)
    static let revision = Expression<Int>(TodoList.Keys.revision)
    static let isDirty = Expression<Bool>(TodoList.Keys.isDirty)
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
    
    static func select(by id: String) -> Table {
        return table.select(*).filter(self.id == id)
    }
    
    static func insert(_ item: TodoList, foreingKeys: [String: String]? = nil) -> Insert? {
        let insertOperation = table.insert(
            id <- item.id,
            revision <- item.revision,
            isDirty <- item.isDirty,
            lastUpdatedOn <- item.lastUpdatedOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss),
            lastUpdatedBy <- item.lastUpdatedBy
        )
        
        return insertOperation
    }
    
    static func update(_ item: TodoList) -> Update {
        let updateOperation = table.update(
            revision <- item.revision,
            isDirty <- item.isDirty,
            lastUpdatedOn <- item.lastUpdatedOn.toString(format: DatetimeFormats.yyyyMMddTHHmmss),
            lastUpdatedBy <- item.lastUpdatedBy
        )
        
        return updateOperation
    }
    
    static func delete(by itemId: String) -> Delete {
        let deleteOperation = table.filter(id == itemId).delete()
        
        return deleteOperation
    }
    
    static func getName() -> String {
        return name
    }
    
    static func getTable() -> Table {
        return table
    }
    
    static func toDomain(rows: AnySequence<Row>) -> [TodoList] {
        var items = [TodoList]()
        
        for row in rows {
            if let item = toDomain(row: row) {
                items.append(item)
            }
        }
        
        return items
    }
    
    static func toDomain(row: Row) -> TodoList? {
        let datetime = Helper.stringToDate(dateStr: row[lastUpdatedOn], dateFormat: DatetimeFormats.yyyyMMddTHHmmss)
        guard let todoListLastUpdatedOn = datetime else { return nil }
        
        let todoListId = row[id]
        let todoListRevision = row[revision]
        let todoListIsDirty = row[isDirty]
        let todoListLastUpdatedBy = row[lastUpdatedBy]
        
        return TodoList(id: todoListId, revision: todoListRevision, isDirty: todoListIsDirty,
                        lastUpdatedBy: todoListLastUpdatedBy, lastUpdatedOn: todoListLastUpdatedOn)
    }
}
