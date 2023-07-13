//
//  JsonSerializator.TodoList.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

final class TodoListJsonSerializator: JsonSerializator {
    typealias Element = TodoList
    
    static func serialize(object: TodoList) -> Any {
        var data = [String: Any]()
        data[TodoList.Keys.revision] = object.revision
        data[TodoList.Keys.isDirty] = object.isDirty
        data[TodoList.Keys.lastUpdatedBy] = object.lastUpdatedBy
        data[TodoList.Keys.lastUpdatedOn] = object.lastUpdatedOn
        data[TodoList.Keys.items] = object.items.map { $0.json }
        
        return data
    }
    
    static func deserialize(data: Any) -> TodoList? {
        guard let dict = data as? [String: Any],
              let revision = dict[TodoList.Keys.revision] as? Int,
              let isDirty = dict[TodoList.Keys.isDirty] as? Bool,
              let lastUpdatedBy = dict[TodoList.Keys.lastUpdatedBy] as? String,
              let lastUpdatedOn = dict[TodoList.Keys.lastUpdatedOn] as? Int,
              let dictItems = dict[TodoList.Keys.items] as? [Any]
        else { return nil }

        var items = [TodoItem]()
        for dictItem in dictItems {
            if let item = TodoItem.parse(json: dictItem) {
                items.append(item)
            }
        }
        
        let lastUpdatedOnValue = Date(timeIntervalSince1970: Double(lastUpdatedOn))

        return TodoList(items: items, revision: revision, isDirty: isDirty,
                        lastUpdatedBy: lastUpdatedBy, lastUpdatedOn: lastUpdatedOnValue)
    }
}
