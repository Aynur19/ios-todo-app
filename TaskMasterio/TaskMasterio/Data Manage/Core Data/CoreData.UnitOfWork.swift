////
////  CoreData.UnitOfWork.swift
////  TaskMasterio
////
////  Created by Aynur Nasybullin on 15.07.2023.
////
//
import Foundation
import CoreData
//
final class CoreDataUnitOfWork {//: UnitOfWork {
    typealias TodoListRepoType = TodoListCoreDataRepository
//    typealias TodoItemRepoType = TodoItemCoreDataRepository
    
    var todoListRepo: TodoListRepoType
//    var todoItemRepo: TodoItemRepoType
    
    
    static var shared = CoreDataUnitOfWork()
    
    private var mainContext: NSManagedObjectContext
    private var backgroundContext: NSManagedObjectContext
    private var persistenceContainer: NSPersistentContainer
    
    private init() {
        let container = NSPersistentContainer(name: "TodoListModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map({ fatalError("Unresolved error \($0)") })
        })
        persistenceContainer = container
//        todoItemRepo = TodoItemRepoType(mainContext: mainContext,
//                                        backgroundContext: backgroundContext)
        
        mainContext = self.persistenceContainer.viewContext
        backgroundContext = self.persistenceContainer.newBackgroundContext()
        todoListRepo = TodoListRepoType(mainContext: self.mainContext,
                                        backgroundContext: backgroundContext)
        self.createDatabaseIfNeeded(persistentContainer: persistenceContainer)
    }
    
    private func isDatabaseExists(persistentContainer: NSPersistentContainer) -> Bool {
        let fileManager = FileManager.default
        guard let storeURL = persistentContainer.persistentStoreDescriptions.first?.url else {
            return false
        }
        return fileManager.fileExists(atPath: storeURL.path)
    }
    
    private func createDatabaseIfNeeded(persistentContainer: NSPersistentContainer) {
        guard !isDatabaseExists(persistentContainer: persistentContainer) else {
            return
        }
        do {
            try persistentContainer.persistentStoreCoordinator
                .addPersistentStore(ofType: NSSQLiteStoreType,
                                    configurationName: nil,
                                    at: persistentContainer.persistentStoreDescriptions.first?.url,
                                    options: nil)
        } catch {
            print("Failed to create persistent store: \(error)")
        }
    }

//    func load(with primaryKey: String?) -> Result<Void, Error> {
//        todoListRepo.getAll()
//        return .success(())
//    }
    
    // MARK: TodoList
//    func get(by id: String) -> TodoList? {
//        return unitOfWork.todoListRepo.get(by: id)
//    }
    
    func getAll() -> [TodoList] {
        return todoListRepo.getAll()
    }
    
    func insert(_ entity: TodoList) -> TodoList? {
        return todoListRepo.insert(entity)
    }
//
    func update(_ entity: TodoList) -> TodoList? {
        return todoListRepo.update(entity)
    }
//
//    func upsert(_ entity: TodoList) -> TodoList? {
//        return unitOfWork.todoListRepo.upsert(entity)
//    }
//
//    func delete(by id: String) -> TodoList? {
//        return unitOfWork.todoListRepo.delete(by: id)
//    }
//
//    // MARK: - TodoItem
//    func getItem(by id: String) -> TodoItem? {
//        return unitOfWork.todoItemRepo.get(by: id)
//    }
//
//    func getItems() -> [TodoItem] {
//        return unitOfWork.todoItemRepo.getAll()
//    }
//
//    func insertItem(_ entity: TodoItem) -> TodoItem? {
//        return unitOfWork.todoItemRepo.insert(entity)
//    }
//
//    func updateItem(_ entity: TodoItem) -> TodoItem? {
//        return unitOfWork.todoItemRepo.update(entity)
//    }
//
//    func upsertItem(_ entity: TodoItem) -> TodoItem? {
//        return unitOfWork.todoItemRepo.upsert(entity)
//    }
//
//    func deleteItem(by id: String) -> TodoItem? {
//        return unitOfWork.todoItemRepo.delete(by: id)
//    }
//
//    // MARK: Load & Save
//    func load() -> Result<Void, Error> {
//        return unitOfWork.load(with: nil)
//    }
    
//    func load(with primaryKey: String? = nil) -> Result<Void, Error> {
//        return unitOfWork.load(with: primaryKey)
//    }
    
    
    func save() -> Result<Void, Error> {
        return .success(())
    }
    //
    //    func load(with primaryKey: String? = nil) -> Swift.Result<Void, Error> {
    //        var result: Swift.Result<Void, Error>
    //
    //        var predicate: NSObject
    //
    //        let fetchRequest = TodoListManagedObject.fetchRequest()
    //
    //        if primaryKey = primaryKey {
    //            predicate = NSPredicate(format: "id == %@", primaryKey)
    //
    //            try
    //        }
    //
    //        if let primaryKey = primaryKey {
    //            todoListTable = TodoListTable.table.filter(TodoListTable.id == primaryKey)
    //            todoItemTable = TodoItemTable.table.filter(TodoItemTable.todoListId == primaryKey)
    //        } else {
    //            todoListTable = TodoListTable.table
    //            todoItemTable = TodoItemTable.table
    //        }
    //
    //        do {
    //            guard let todoListRows = try dbConnection?.prepare(todoListTable),
    //                  let todoItemRows = try dbConnection?.prepare(todoItemTable)
    //            else {
    //                throw FileCacheError.castingToDictionaryFailed
    //            }
    //
    //            todoListContext.context.removeAll()
    //            todoListContext.context.append(contentsOf: TodoListTable.toDomain(rows: todoListRows))
    //
    //            todoItemContext.context.removeAll()
    //            todoItemContext.context.append(contentsOf: TodoItemTable.toDomain(rows: todoItemRows))
    //
    //            result = .success(())
    //        } catch {
    //            print(error)
    //            result = .failure(error)
    //        }
    //
    //        return result
    //    }
    //
    //    func save() -> Swift.Result<Void, Error> {
    //        var result: Swift.Result<Void, Error>
    //        do {
    //            try dbConnection?.transaction {
    //                for insert in todoListRepo.inserts { try dbConnection?.run(insert) }
    //                for update in todoListRepo.updates { try dbConnection?.run(update) }
    //                for delete in todoListRepo.deletes { try dbConnection?.run(delete) }
    //
    //                for insert in todoItemRepo.inserts { try dbConnection?.run(insert) }
    //                for update in todoItemRepo.updates { try dbConnection?.run(update) }
    //                for delete in todoItemRepo.deletes { try dbConnection?.run(delete) }
    //            }
    //
    //            todoListRepo.clearInserts()
    //            todoListRepo.clearUpdates()
    //            todoListRepo.clearDeletes()
    //
    //            todoItemRepo.clearInserts()
    //            todoItemRepo.clearUpdates()
    //            todoItemRepo.clearDeletes()
    //
    //            result = .success(())
    //        } catch {
    //            print("ОШИБКА: \(error)")
    //            result = .failure(error)
    //        }
    //
    //        return result
    //    }
    //
    //    private func configureConnectionString() {
    //        var path: String
    //        if let connectionUrl = connectionUrl {
    //            path = Helper.getPathFromUrl(connectionUrl)
    //        } else {
    //            guard let defaultPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
    //                return
    //            }
    //            path = defaultPath
    //        }
    //
    //        connectionString = (path as NSString).appendingPathComponent("\(name).sqlite")
    //        print("Получен путь к файлу базы данных SQLite: \(connectionString)")
    //
    //        let fileManager = FileManager.default
    //        if !fileManager.fileExists(atPath: connectionString) {
    //            do {
    //                try Helper.checkAndCreateDirectory(path: path)
    //            } catch {
    //                print(error)
    //            }
    //            print("Файл базы данных SQLite не обнаружен по полученному пути!")
    //            let success = fileManager.createFile(atPath: connectionString, contents: nil, attributes: nil)
    //
    //            if success {
    //                print("Создан файл базы данных SQLite по полученному пути!")
    //            } else {
    //                print("Не удалось создать файл базы дынных SQLite по полученному пути!")
    //            }
    //        } else {
    //            print("Файл базы данных SQLite обнаружен по полученному пути!")
    //        }
    //    }
    //
    //    private func connect() -> Bool {
    //        do {
    //            dbConnection = try Connection(connectionString)
    //            print("Выполенено подключение к базе данных SQLite по пути: \(connectionString)")
    //
    //#if DEBUG
    //            dbConnection?.trace { print($0) }
    //#endif
    //            return true
    //        } catch {
    //            dbConnection = nil
    //            print("не удалось выполнить подключение к базе данных SQLite по пути: \(connectionString)")
    //            return false
    //        }
    //    }
    //
    //    private func createDatabase() {
    //        if !tableExists(TodoListTable.self) {
    //            createTable(TodoListTable.self)
    //        }
    //
    //        if !tableExists(TodoItemTable.self) {
    //            createTable(TodoItemTable.self)
    //        }
    //    }
    //
    //    private func tableExists<T: SqliteTable>(_ type: T.Type) -> Bool {
    //        let query = "SELECT name FROM sqlite_master WHERE type='table' AND name='\(T.getName())'"
    //        do {
    //            print("Проверка наличия в базе данных таблицы '\(T.getName())'...")
    //            let result = try dbConnection?.scalar(query) as? String
    //            return result != nil
    //        } catch {
    //            print("Ошибка при проверке наличия таблицы: \(error)")
    //            return false
    //        }
    //    }
    //
    //    private func createTable<T: SqliteTable>(_ type: T.Type) {
    //        do {
    //            print("Попытка создания таблицы \(T.getName())...")
    //            try T.createTable(dbConnection: dbConnection)
    //            print("  Таблица успешно создана!")
    //        } catch {
    //            print("  Не удалось создать таблицу: \(error)")
    //        }
    //    }
    //}
}
