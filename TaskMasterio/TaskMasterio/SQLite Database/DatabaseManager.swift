//
//  DatabaseManager.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import Foundation
import SQLite

final class DatabaseManager: DataCachable {
    
    
    var context: TodoList
    
    static let shared = DatabaseManager()
    private var connectionString = ""
    private var dbConnection: Connection? = nil
    
    private init() {
        dbConnection = nil
        context = TodoList()
    }
    
    func configure(name: String, connectionUrl: URL? = nil) {
        configureConnectionString(name: name, connectionUrl: connectionUrl)
        
        if !connectionString.isEmpty,
           connect() {
            createDatabase()
        }
    }
    
    private func configureConnectionString(name: String, connectionUrl: URL? = nil) {
        let path = connectionUrl?.path ?? NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = (path as NSString?)?.appendingPathComponent("\(name).sqlite")
        
        if let filePath = filePath {
            connectionString = filePath
            print("Получен путь к файлу базы данных SQLite: \(connectionString)")
            
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: connectionString) {
                print("Файл базы данных SQLite не обнаружен по полученному пути!")
                let success = fileManager.createFile(atPath: connectionString, contents: nil, attributes: nil)
                
                if success {
                    print("Создан файл базы данных SQLite по полученному пути!")
                } else {
                    print("Не удалось создать файл базы дынных SQLite по полученному пути!")
                }
            } else {
                print("Файл базы данных SQLite обнаружен по полученному пути!")
            }
        } else {
            print("Не удалось получить путь к файлу базы данных SQLite!")
        }
    }
    
    private func connect() -> Bool {
        do {
            dbConnection = try Connection(connectionString)
            print("Выполенено подключение к базе данных SQLite по пути: \(connectionString)")
            return true
        } catch {
            dbConnection = nil
            print("не удалось выполнить подключение к базе данных SQLite по пути: \(connectionString)")
            return false
        }
    }
    
    private func createDatabase() {
        if !tableExists(TodoListTable.self) {
            createTable(TodoListTable.self)
        }
        
        if !tableExists(TodoItemTable.self) {
            createTable(TodoItemTable.self)
        }
    }
    
    private func createTable<T: SqliteTable>(_ of: T.Type) {
        do {
            print("Попытка создания таблицы \(T.getName())...")
            try T.createTable(dbConnection: dbConnection)
//            try dbConnection?.run(TodoListTable.table.create { table in
//                table.column(TodoListTable.id, primaryKey: true)
//                table.column(TodoListTable.revision)
//                table.column(TodoListTable.isDirty)
//                table.column(TodoListTable.lastUpdatedOn)
//                table.column(TodoListTable.lastUpdatedBy)
//            })
            
//            try dbConnection?.run(TodoItemTable.table.create { table in
//                table.column(TodoItemTable.id, primaryKey: true)
//                table.foreignKey(TodoItemTable.todoListId,
//                                 references: TodoListTable.table, TodoListTable.id)
//                table.column(TodoItemTable.text)
//                table.column(TodoItemTable.priority)
//                table.column(TodoItemTable.deadline)
//                table.column(TodoItemTable.isDone)
//                table.column(TodoItemTable.createdOn)
//                table.column(TodoItemTable.updatedOn)
//            })
            
            print("  Таблица успешно создана!")
        } catch {
            print("  Не удалось создать таблицу: \(error)")
        }
    }
    
    func tableExists<T: SqliteTable>(_ of: T.Type) -> Bool {
        let query = "SELECT name FROM sqlite_master WHERE type='table' AND name='\(T.getName())'"
        do {
            print("Проверка наличия в базе данных таблицы '\(T.getName())'...")
            let result = try dbConnection?.scalar(query) as? String
            return result != nil
        } catch {
            print("Ошибка при проверке наличия таблицы: \(error)")
            return false
        }
    }
    
    func updateMetadata(revision: Int, isDurty: Bool, lastUpdatedBy: String, lastUpdatedOn: Int) {
        
    }
    
    func load() -> Swift.Result<Void, Error> {
        var result: Swift.Result<Void, Error> = .success(())
        
        return result
    }
    
    func clearContext() {
        
    }
    
    func get(by id: String) -> TodoItem? {
        return nil
    }
    
    func insert(_ item: TodoItem) -> TodoItem? {
        return nil
    }
    
    func update(_ item: TodoItem) -> TodoItem? {
        return nil
    }
    
    func insertOrUpdate(_ item: TodoItem) -> TodoItem? {
        return nil
    }
    
    func delete(by id: String) -> TodoItem? {
        return nil
    }
    
    func save() -> Swift.Result<Void, Error>  {
        return .success(())
    }
}
