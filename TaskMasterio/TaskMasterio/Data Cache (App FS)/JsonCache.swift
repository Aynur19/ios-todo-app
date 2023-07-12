//
//  TodoItemJsonCache.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

final class JsonCache: DataCachable {
    private(set) var context: TodoList
    
    private var name: String
    private var url: URL?
    
    init(context: TodoList = TodoList(), name: String, url: URL? = nil) throws {
        self.context = context
        self.name = name
        self.url = url
    }
    
    func configure(name: String, connectionUrl: URL? = nil) {
        self.name = name
        self.url = connectionUrl
    }
    
    func updateMetadata(revision: Int, isDurty: Bool = false, lastUpdatedBy: String = "default", lastUpdatedOn: Int = Date().datetime) {
        context.revision = revision
        context.isDirty = isDurty
        context.lastUpdatedOn = lastUpdatedOn
        context.lastUpdatedBy = lastUpdatedBy
    }
    
    func load() -> Result<Void, Error> {
        var result: Result<Void, Error>
        do {
            let jsonUrl = try getURL()
            let jsonData = try Data(contentsOf: jsonUrl)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            
            guard let newContext = TodoList.parse(json: jsonObject) else {
                throw FileCacheError.castingToDictionaryFailed
            }
            
            clearContext()
            context = newContext
            result = .success(())
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    func clearContext() {
        context.items.removeAll()
    }
    
    func get(by id: String) -> TodoItem? {
        return context.items.first(where: { $0.id == id })
    }
    
    func insert(_ item: TodoItem) -> TodoItem? {
        if let foundedItem = get(by: item.id) { return foundedItem }
        context.items.append(item)
        
        return nil
    }
    
    func update(_ item: TodoItem) -> TodoItem? {
        var updatedItem: TodoItem?
        if let idx = context.items.firstIndex(where: { $0.id == item.id }) {
            updatedItem = context.items[idx]
            context.items[idx] = item
        }
        
        return updatedItem
    }
    
    func insertOrUpdate(_ item: TodoItem) -> TodoItem? {
        if let updatedItem = update(item) { return updatedItem }
        context.items.append(item)
        
        return nil
    }
    
    func delete(by id: String) -> TodoItem? {
        var deletedItem: TodoItem?
        if let idx = context.items.firstIndex(where: { $0.id == id }) {
            deletedItem = context.items[idx]
            context.items.remove(at: idx)
        }
        
        return deletedItem
    }
    
    func save() -> Result<Void, Error> {
        var result: Result<Void, Error>
        let contextJson = context.json
        do {
            let jsonUrl = try getURL()
            let jsonData = try JSONSerialization.data(withJSONObject: contextJson, options: .prettyPrinted)
            try jsonData.write(to: jsonUrl)
            result = .success(())
        } catch {
            result = .failure(error)
        }
        
        return result
    }
    
    private func getURL() throws -> URL {
        let fileManager = FileManager.default
        guard var fileURL = url ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileCacheError.notPassedDataURL
        }
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.createDirectory(atPath: fileURL.path,
                                                withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw FileCacheError.folderCreatingFailed(path: fileURL.path, error: error)
            }
        }
        
        fileURL.appendPathComponent(name)
        fileURL.appendPathExtension(DataStoreType.json.rawValue)
        
        return fileURL
    }
}
