//
//  Sqlite.UnitOfWork.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation
import SQLite

final class SqliteUnitOfWork: UnitOfWork {
    typealias TodoListRepoType = SqliteTodoListRepository
    typealias TodoItemRepoType = SqliteTodoItemRepository
    
    private(set) var todoListContext: TodoListContext
    private(set) var todoItemContext: TodoItemContext
    
    private(set) var todoListRepo: TodoListRepoType
    private(set) var todoItemRepo: TodoItemRepoType
    
    private(set) var name = String()
    private(set) var connectionUrl: URL?
    
    private var connectionString = String()
    private var dbConnection: Connection?
    
    init(todoListContext: TodoListContext, todoItemContext: TodoItemContext) {
        self.todoListContext = todoListContext
        self.todoItemContext = todoItemContext
        
        self.todoListRepo = SqliteTodoListRepository(context: self.todoListContext)
        self.todoItemRepo = SqliteTodoItemRepository(context: self.todoItemContext)
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
        
        do {
            guard let todoListRows = try dbConnection?.prepare(TodoListTable.table),
                  let todoList = TodoListTable.toDomain(rows: todoListRows).first
            else {
                throw FileCacheError.castingToDictionaryFailed
            }
            
            let select = TodoItemTable.table.select(*).filter(TodoItemTable.todoListId == todoList.id)
            guard let todoItemRows = try dbConnection?.prepare(select) else {
                throw FileCacheError.castingToDictionaryFailed
            }
                    
            todoListContext.context.append(todoList)
            todoItemContext.context = TodoItemTable.toDomain(rows: todoItemRows)
            
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
            try dbConnection?.transaction {
                for insert in todoListRepo.inserts { try dbConnection?.run(insert) }
                for update in todoListRepo.updates { try dbConnection?.run(update) }
                for delete in todoListRepo.deletes { try dbConnection?.run(delete) }
                
                for insert in todoItemRepo.inserts { try dbConnection?.run(insert) }
                for update in todoItemRepo.updates { try dbConnection?.run(update) }
                for delete in todoItemRepo.deletes { try dbConnection?.run(delete) }
            }
            
            todoListRepo.clearInserts()
            todoListRepo.clearUpdates()
            todoListRepo.clearDeletes()
            
            todoItemRepo.clearInserts()
            todoItemRepo.clearUpdates()
            todoItemRepo.clearDeletes()
            
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
        
        if !tableExists(TodoItemTable.self) {
            createTable(TodoItemTable.self)
        }
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
