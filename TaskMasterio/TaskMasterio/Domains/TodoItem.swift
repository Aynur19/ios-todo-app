//
//  TodoItem.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import Foundation

struct TodoItem: StringIdentifiable {
    let id: String
    let text: String
    let priority: TodoItemPriority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    let color: String
    let todoListId: String
    
    init(
        id: String = UUID().uuidString,
        text: String,
        priority: TodoItemPriority,
        deadline: Date? = nil,
        isDone: Bool = false,
        createdOn: Date = Date(),
        updatedOn: Date? = nil,
        color: String = "#FFFFFF",
        todoListId: String
    ) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
        self.color = color
        self.todoListId = todoListId
    }
    
    enum Keys {
        static let id = "id"
        static let text = "text"
        static let priority = "priority"
        static let deadline = "deadline"
        static let isDone = "isDone"
        static let createdOn = "createdOn"
        static let updatedOn = "updatedOn"
        static let color = "color"
        static let todoListId = "todoListId"
    }
}

extension TodoItem: JsonSerializable {
    var json: Any { return TodoItemJsonSerializator.serialize(object: self) }
    
    static func parse(json: Any) -> TodoItem? {
        return TodoItemJsonSerializator.deserialize(data: json)
    }
}

extension TodoItem: CsvSerializable {
    var csv: String { return TodoItemCsvSerializator.serialize(object: self) }
    
    static func parse(csv: String) -> TodoItem? {
        return TodoItemCsvSerializator.deserialize(data: csv)
    }
}
