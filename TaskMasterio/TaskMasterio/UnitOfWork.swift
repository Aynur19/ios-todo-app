//
//  UnitOfWork.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation
import SQLite

protocol UnitOfWork: DataStore {
    associatedtype TodoListRepoType: TodoListRepository
    
    var todoLisrRepo: TodoListRepoType { get }
    
    var name: String { get }
    var connectionUrl: URL? { get }
    
    func configure(name: String, connectionUrl: URL?)
    
    func load() -> Swift.Result<Void, Error>
    func save() -> Swift.Result<Void, Error>
}

class SqliteUnitOfWork: UnitOfWork {
    typealias TodoListRepoType = SqliteTodoListRepository
    
    private(set) var todoListContext: TodoListContext
    private(set) var todoItemContext: TodoItemContext?
    
    private(set) var todoLisrRepo: TodoListRepoType
    
    private(set) var name = String()
    private(set) var connectionUrl: URL?
    
    private var connectionString = String()
    private var dbConnection: Connection?
    
    init(context1: TodoListContext) {
        self.todoListContext = context1
        self.todoLisrRepo = SqliteTodoListRepository(context: self.todoListContext)
    }
    
    func configure(name: String, connectionUrl: URL? = nil) {
        self.name = name
        self.connectionUrl = connectionUrl
        
        configureConnectionString()
        
        if !connectionString.isEmpty {
            if connect() {
                createDatabase()
            }
        }
    }
    
    func load() -> Swift.Result<Void, Error> {
        var result: Swift.Result<Void, Error>
        
//        let select = TodoListTable.select()
        //        let select = TodoListTable.select(by: "C16291BC-E107-4F5B-9E0E-6642DFB4CC0A")
//        let select2 = TodoItemTable.select(with: "C16291BC-E107-4F5B-9E0E-6642DFB4CC0A")
        
        do {
            guard let rows = try dbConnection?.prepare(TodoListTable.table)/*,
                  let rows2 = try dbConnection?.prepare(select2)*/
            else {
                throw FileCacheError.castingToDictionaryFailed
            }
            
            todoListContext.context = TodoListTable.toDomain(rows: rows)
//            context
//            context.todoLists.removeAll()
//            context1.context.removeAll()
//            context1.context.append(contentsOf: todoList)
//            context.items.append(contentsOf: TodoItemTable.toDomain(rows: rows2))
            result = .success(())
        } catch {
            print(error)
            result = .failure(error)
        }
        
        return result
    }
    
    func save() -> Swift.Result<Void, Error> {
        var result: Swift.Result<Void, Error>
        do {
//            let count = try dbConnection?.scalar(TodoListTable.table.filter(TodoListTable.id == context.id).count)
//
//            if let count = count, count > 0 {
//                print("Запись с id \(context.id) найдена в таблице")
//            } else {
//                print("Запись с id \(context.id) не найдена в таблице")
//
//                if let insert = TodoListTable.insert(context, foreingKeys: [:]) {
//                    try dbConnection?.run(insert)
//                }
//            }
            
            try dbConnection?.transaction {
                for insert in todoLisrRepo.inserts { try dbConnection?.run(insert) }
                for update in todoLisrRepo.updates { try dbConnection?.run(update) }
                for delete in todoLisrRepo.deletes { try dbConnection?.run(delete) }
            }
            
            todoLisrRepo.clearInserts()
            todoLisrRepo.clearUpdates()
            todoLisrRepo.clearDeletes()
            
            result = .success(())
        } catch {
            print("ОШИБКА: \(error)")
            result = .failure(error)
        }
        
        return result
    }
    
    private func configureConnectionString() {
        var path: String
        if let connectionUrl = connectionUrl {
            path = Helper.getPathFromUrl(connectionUrl)
        } else {
            guard let defaultPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return
            }
            path = defaultPath
        }
        
        connectionString = (path as NSString).appendingPathComponent("\(name).sqlite")
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
            
#if DEBUG
            dbConnection?.trace { print($0) }
#endif
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
        
//        if !tableExists(TodoItemTable.self) {
//            createTable(TodoItemTable.self)
//        }
    }
    
    private func tableExists<T: SqliteTable>(_ type: T.Type) -> Bool {
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
    
    private func createTable<T: SqliteTable>(_ type: T.Type) {
        do {
            print("Попытка создания таблицы \(T.getName())...")
            try T.createTable(dbConnection: dbConnection)
            print("  Таблица успешно создана!")
        } catch {
            print("  Не удалось создать таблицу: \(error)")
        }
    }
}
