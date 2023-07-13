//
//  DatabaseManager.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import Foundation
import SQLite

final class DatabaseManager: DataCachable {
    private let datetimeFormat = "yyyy-MM-dd HH:mm:ss"
    var context: TodoList
    
    static let shared = DatabaseManager()
    private var connectionString = ""
    private var dbConnection: Connection?
    
    private var inserts = [Insert]()
    private var updates = [Update]()
    private var deletes = [Delete]()
    
    private init() {
        dbConnection = nil
        context = TodoList()
    }
    
    func traceQueries(isOn: Bool = false) {
        if isOn { dbConnection?.trace { print($0) } }
    }
//    private func removeOperation(by id: String) {
//        inserts[id] = nil
//        updates[id] = nil
//        deletes[id] = nil
//    }
    
    func configure(name: String, connectionUrl: URL? = nil) {
        configureConnectionString(name: name, connectionUrl: connectionUrl)
        
        if !connectionString.isEmpty {
            if connect() {
                createDatabase()
            }
        }
    }
    
    private func configureConnectionString(name: String, connectionUrl: URL? = nil) {
        var path: String
        if let url = connectionUrl {
            path = Helper.getPathFromUrl(url)
        } else {
            guard let defaultPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return
            }
            path = defaultPath
        }
        
        let filePath = (path as NSString).appendingPathComponent("\(name).sqlite")
        connectionString = filePath
        print("Получен путь к файлу базы данных SQLite: \(connectionString)")
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: connectionString) {
            do {
                try Helper.checkAndCreateDirectory(path: path)
            } catch {
                print(error)
            }
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
    
    private func createTable<T: SqliteTable>(_ type: T.Type) {
        do {
            print("Попытка создания таблицы \(T.getName())...")
            try T.createTable(dbConnection: dbConnection)
            print("  Таблица успешно создана!")
        } catch {
            print("  Не удалось создать таблицу: \(error)")
        }
    }
    
    func tableExists<T: SqliteTable>(_ type: T.Type) -> Bool {
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
    
    func updateMetadata(revision: Int, isDurty: Bool, lastUpdatedBy: String, lastUpdatedOn: Date) {
        
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
        if let foundedItem = context.items.first(where: { $0.id == item.id }) { return foundedItem }
        context.items.append(item)
    
        if let insert = TodoItemTable.insert(item, foreingKeys: [TodoItemTable.foreignKey: context.id]) {
            inserts.append(insert)
        }
        
        return nil
    }
    
    func update(_ item: TodoItem) -> TodoItem? {
        var updatedItem: TodoItem?
        if let idx = context.items.firstIndex(where: { $0.id == item.id }) {
            updatedItem = context.items[idx]
            context.items[idx] = item
            
            updates.append(TodoItemTable.update(item))
        }
        
        return updatedItem
    }
    
    func insertOrUpdate(_ item: TodoItem) -> TodoItem? {
        if let updatedItem = update(item) {
            return updatedItem
        }
        
        context.items.append(item)
        if let insert = TodoItemTable.insert(item, foreingKeys: [TodoItemTable.foreignKey: context.id]) {
            inserts.append(insert)
        }
        
        return nil
    }
    
    func delete(by id: String) -> TodoItem? {
        return nil
    }
    
    func save() -> Swift.Result<Void, Error>  {
        var result: Swift.Result<Void, Error>
        do {
            let count = try dbConnection?.scalar(TodoListTable.table.filter(TodoListTable.id == context.id).count)
            
            if let count = count, count > 0 {
                print("Запись с id \(context.id) найдена в таблице")
            } else {
                print("Запись с id \(context.id) не найдена в таблице")
                
                if let insert = TodoListTable.insert(context, foreingKeys: [:]) {
                    try dbConnection?.run(insert)
                }
            }
            
            
            try dbConnection?.transaction {
                for insert in inserts { try dbConnection?.run(insert) }
                for update in updates { try dbConnection?.run(update) }
                for delete in deletes { try dbConnection?.run(delete) }
            }
            
            inserts.removeAll()
            updates.removeAll()
            deletes.removeAll()
            
            result = .success(())
        } catch {
            print("ОШИБКА: \(error)")
            result = .failure(error)
        }
        
        return result
    }
}
