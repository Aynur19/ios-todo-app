//
//  DataStore.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 13.07.2023.
//

import Foundation
//import SQLite

protocol DataStore {
    var name: String { get }
    var connectionUrl: URL? { get }
    
    func configure(name: String, connectionUrl: URL?)
    
    func load() -> Result<Void, Error>
    func save() -> Result<Void, Error>
}


//class SqliteTodoItemRepository: TodoItemRepository, SqliteRepository {
//    typealias Entity = TodoItem
//
//    private(set) var inserts = [Insert]()
//    private(set) var updates = [Update]()
//    private(set) var deletes = [Delete]()
//
//    func load() -> Swift.Result<Void, Error> {
//        return .success(())
//    }
//    func save() -> Swift.Result<Void, Error> {
//        return .success(())
//    }
//
//    override func insert(_ entity: Entity) -> Entity? {
//        if let foundedItem = super.insert(entity) {
//            return foundedItem
//        }
//
////        if let insert = TodoItemTable.insert(entity) {
//            inserts.append(insert)
//        }
//
//        return nil
//    }
//
//    override func update(_ entity: Entity) -> Entity? {
//        guard let updatedItem = super.update(entity) else { return nil }
//
//        updates.append(TodoItemTable.update(entity))
//        return updatedItem
//    }
//
//    override func upsert(_ entity: Entity) -> Entity? {
//        if let updatedItem = update(entity) {
//            return updatedItem
//        }
//
//        return insert(entity)
//    }
//
//    override func delete(by id: String) -> Entity? {
//        guard let deletedItem = super.delete(by: id) else { return nil }
//        deletes.append(TodoListTable.delete(by: id))
//
//        return deletedItem
//    }
//}

//class TodoListRepository: BaseRepository<TodoList> {
////    typealias Entity = TodoList
////    private(set) var context: DataContext
////
////    init(context: DataContext) {
////        self.context = context
////    }
////
////    func get(by id: String) -> Entity? {
////        return context.todoLists.first { $0.id == id }
////    }
////
////    func getAll() -> [Entity] {
////        return context.todoLists
////    }
////
////    func insert(_ entity: Entity) -> Entity? {
////        if let foundedItem = get(by: entity.id) {
////            return foundedItem
////        }
////        context.todoLists.append(entity)
////
////        return nil
////    }
////
////    func update(_ entity: Entity) -> Entity? {
////        var updatedItem: Entity?
////        if let idx = context.todoLists.firstIndex(where: { $0.id == entity.id }) {
////            updatedItem = context.todoLists[idx]
////            context.todoLists[idx] = entity
////        }
////
////        return updatedItem
////    }
////
////    func upsert(_ entity: Entity) -> Entity? {
////        if let updatedItem = update(entity) {
////            return updatedItem
////        }
////        context.todoLists.append(entity)
////
////        return nil
////    }
////
////    func delete(by id: String) -> Entity? {
////        var deletedItem: Entity?
////        if let idx = context.todoLists.firstIndex(where: { $0.id == id }) {
////            deletedItem = context.todoLists[idx]
////            context.todoLists.remove(at: idx)
////        }
////
////        return deletedItem
////    }
//}
//
//class TodoItemRepository {
//    typealias Entity = TodoItem
//    private(set) var context: DataContext
//
//    func get(by id: String) -> Entity? {
//        return context.to.first { $0.id == id }
//    }
//
//    func getAll() -> [Entity] {
//        return context.todoLists
//    }
//
//    func insert(_ entity: Entity) -> Entity? {
//        if let foundedItem = get(by: entity.id) {
//            return foundedItem
//        }
//        context.todoLists.append(entity)
//
//        return nil
//    }
//
//    func update(_ entity: Entity) -> Entity? {
//        var updatedItem: Entity?
//        if let idx = context.todoLists.firstIndex(where: { $0.id == entity.id }) {
//            updatedItem = context.todoLists[idx]
//            context.todoLists[idx] = entity
//        }
//
//        return updatedItem
//    }
//
//    func upsert(_ entity: Entity) -> Entity? {
//        if let updatedItem = update(entity) {
//            return updatedItem
//        }
//        context.todoLists.append(entity)
//
//        return nil
//    }
//
//    func delete(by id: String) -> Entity? {
//        var deletedItem: Entity?
//        if let idx = context.todoLists.firstIndex(where: { $0.id == id }) {
//            deletedItem = context.todoLists[idx]
//            context.todoLists.remove(at: idx)
//        }
//
//        return deletedItem
//    }
//}
//
//protocol SubEntityRepository {
//    associatedtype SubEntity: StringIdentifiable
//
//    func get(with foreignKey: String, by id: String) -> SubEntity?
//    func getAll(with foreignKey: String) -> [SubEntity]
//    func insert(_ entity: SubEntity) -> SubEntity?
//    func update(_ entity: SubEntity) -> SubEntity?
//    func upsert(_ entity: SubEntity) -> SubEntity?
//    func delete(by id: String) -> SubEntity?
//}
//
//protocol TodoListRepository {
//    func get(by id: String) -> TodoList?
//    func getAll() -> [TodoList]
//    func saveTodoList(_ todoList: TodoList)
//    func deleteTodoList(withID id: String)
//}
//
//protocol TodoItemRepository {
//    func getAllTodoItems() -> [TodoItem]
//    func getTodoItems(inListWithID listID: String) -> [TodoItem]
//    func saveTodoItem(_ todoItem: TodoItem)
//    func deleteTodoItem(withID id: String)
//}
//
//protocol DataStorage {
//    func saveData<T: Codable>(_ data: T, forKey key: String)
//    func loadData<T: Codable>(forKey key: String) -> T?
//    func deleteData(forKey key: String)
//}


//
////protocol DataStore {
////    var name: String { get }
////    var sourceUrl: URL? { get }
////
////    func cinfigure(name: String, connectionUrl: URL?)
////
////    func load() -> Result<Void, Error>
////
////    func save() -> Result<Void, Error>
////}
//
//
//protocol DataContext {
//    associatedtype Entity
//    func clearContext()
//    func get(by id: String) -> Entity?
//    func insert(_ item: Entity) -> Entity?
//    func update(_ item: Entity) -> Entity?
//    func insertOrUpdate(_ item: Entity) -> Entity?
//    func delete(by id: String) -> Entity?
//}
//
//class BaseDataContext<T: StringIdentifiable>: DataContext {
//    typealias Entity = T
//    private(set) var context: [Entity]
//    init(context: [Entity] = [Entity]()) {
//        self.context = context
//    }
//
//    func clearContext() {
//        context.removeAll()
//    }
//
//    func get(by id: String) -> Entity? {
//        return context.first(where: { $0.id == id })
//    }
//    func insert(_ item: Entity) -> Entity? {
//        if let foundedItem = get(by: item.id) {
//            return foundedItem
//        }
//
//        context.append(item)
//        return nil
//    }
//    func update(_ item: Entity) -> Entity? {
//        var updatedItem: Entity?
//        if let idx = context.firstIndex(where: { $0.id == item.id }) {
//            updatedItem = context[idx]
//            context[idx] = item
//        }
//
//        return updatedItem
//    }
//    func insertOrUpdate(_ item: Entity) -> Entity? {
//        if let updatedItem = update(item) {
//            return updatedItem
//        }
//
//        context.append(item)
//        return nil
//    }
//    func delete(by id: String) -> Entity? {
//        var deletedItem: Entity?
//        if let idx = context.firstIndex(where: { $0.id == id }) {
//            deletedItem = context[idx]
//            context.remove(at: idx)
//        }
//
//        return deletedItem
//    }
//}
//
//protocol DataStore {
//    var name: String { get }
//    var sourceUrl: URL? { get }
//    func configure(name: String, connectionUrl: URL?)
//    func load() -> Result<Void, Error>
//    func save() -> Result<Void, Error>
//
//    // Оборачиваем функции протокола DataContext
//    func get<T: StringIdentifiable>(by id: String) -> T?
//    func insert<T: StringIdentifiable>(_ item: T) -> T?
//    func update<T: StringIdentifiable>(_ item: T) -> T?
//    func insertOrUpdate<T: StringIdentifiable>(_ item: T) -> T?
//    func delete<T: StringIdentifiable>(by id: String) -> T?
//}
//
////protocol BaseDataStore: /*DataContext,*/ DataStore {
//////    private(set) var name: String
//////
//////    private(set) var sourceUrl: URL?
//////
////    var todoListContext: BaseDataContext<TodoList> { get }
////
////    var todoItemContext: BaseDataContext<TodoItem> { get }
////
////
//////    func clearContext() {
//////        todoItemContext.clearContext()
//////        todoListContext.clearContext()
//////    }
//////
//////    func cinfigure(name: String, connectionUrl: URL?) {
//////        <#code#>
//////    }
//////
//////    func load() -> Result<Void, Error> {
//////        <#code#>
//////    }
//////
//////    func save() -> Result<Void, Error> {
//////        <#code#>
//////    }
//////
//////
//////
////}
//
//class JsonDataStore: DataStore {
//    private(set) var name = String()
//    private(set) var sourceUrl: URL?
//
//    private(set) var todoListContext: BaseDataContext<TodoList>
//    private(set) var todoItemContext: BaseDataContext<TodoItem>
//
//    init(
//        todoListContext: BaseDataContext<TodoList>,
//        todoItemContext: BaseDataContext<TodoItem>
//    ) {
//        self.todoListContext = todoListContext
//        self.todoItemContext = todoItemContext
//    }
//
//    func cinfigure(name: String, connectionUrl: URL?) {
//        self.name = name
//        self.sourceUrl = connectionUrl
//    }
//
//    func load() -> Result<Void, Error> {
//        var result: Result<Void, Error>
//        do {
//            let jsonUrl = try getURL()
//            let jsonData = try Data(contentsOf: jsonUrl)
//            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
//
//            guard let newContext = TodoList.parse(json: jsonObject) else {
//                throw FileCacheError.castingToDictionaryFailed
//            }
//
//            todoItemContext.clearContext()
//            todoListContext.clearContext()
//
//            _ = todoListContext.insert(newContext)
//            for item in newContext.items {
//                _ = todoItemContext.insert(item)
//            }
////            context = newContext
//            result = .success(())
//        } catch {
//            result = .failure(error)
//        }
//
//        return result
//    }
//
//    func save() -> Result<Void, Error> {
//        var result: Result<Void, Error>
//        let contextJson = context.json
//        do {
//            let jsonUrl = try getURL()
//            let jsonData = try JSONSerialization.data(withJSONObject: contextJson, options: .prettyPrinted)
//            try jsonData.write(to: jsonUrl)
//            result = .success(())
//        } catch {
//            result = .failure(error)
//        }
//
//        return result
//    }
//
//    private func getURL() throws -> URL {
//        let fileManager = FileManager.default
//        guard var fileURL = url ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            throw FileCacheError.notPassedDataURL
//        }
//
//        if !fileManager.fileExists(atPath: fileURL.path) {
//            do {
//                try fileManager.createDirectory(atPath: fileURL.path,
//                                                withIntermediateDirectories: true, attributes: nil)
//            } catch {
//                throw FileCacheError.folderCreatingFailed(path: fileURL.path, error: error)
//            }
//        }
//
//        fileURL.appendPathComponent(name)
//        fileURL.appendPathExtension(DataStoreType.json.rawValue)
//
//        return fileURL
//    }
//}
