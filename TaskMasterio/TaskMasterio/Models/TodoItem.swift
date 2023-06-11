//
//  TodoItem.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import Foundation

enum Priority {
    case high
    case medium
    case low
}

struct TodoItem {
    let id: String
    let text: String
    let priority: Priority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    
    init(id: String = UUID().uuidString, text: String, priority: Priority, deadline: Date, isDone: Bool,
         createdOn: Date, updatedOn: Date?) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}

extension TodoItem {
    var json: Any {
        ""
    }
    
    static func parse(json: Any) -> TodoItem? {
        return nil
    }
}
