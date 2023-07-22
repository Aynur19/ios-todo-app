//
//  TodoItem.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import Foundation

struct TodoItem {
    let id: String
    let text: String
    let priority: TodoItemPriority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    let color: String
    
    init(
        id: String = UUID().uuidString,
        text: String,
        priority: TodoItemPriority,
        deadline: Date? = nil,
        isDone: Bool = false,
        createdOn: Date = Date(),
        updatedOn: Date? = nil,
        color: String = "#FFFFFF"
    ) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
        self.color = color
    }
}
