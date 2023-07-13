//
//  TodoList.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoList {
    let id: String
    var revision: Int
    var isDirty: Bool
    var lastUpdatedBy: String
    var lastUpdatedOn: Date
    var items: [TodoItem]
    
    init(id: String = UUID().uuidString,
         items: [TodoItem] = [TodoItem](),
         revision: Int = 0,
         isDirty: Bool = false,
         lastUpdatedBy: String = "",
         lastUpdatedOn: Date = Date()
    ) {
        self.id = id
        self.items = items
        self.revision = revision
        self.isDirty = isDirty
        self.lastUpdatedBy = lastUpdatedBy
        self.lastUpdatedOn = lastUpdatedOn
    }
    
    enum Keys {
        static let id = "id"
        static let items = "items"
        static let revision = "revision"
        static let isDirty = "isDirty"
        static let lastUpdatedBy = "lastUpdatedBy"
        static let lastUpdatedOn = "lastUpdatedOn"
    }
}

extension TodoList: JsonSerializable {
    var json: Any { return TodoListJsonSerializator.serialize(object: self) }
    
    static func parse(json: Any) -> TodoList? {
        return TodoListJsonSerializator.deserialize(data: json)
    }
}
