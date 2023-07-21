//
//  TodoItem.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
//

import Foundation
import Combine

class TodoItemViewModel: ObservableObject {
    
    let id: String
    @Published var text: String
    @Published var priority: TodoItemPriority
    @Published var deadline: Date?
    @Published var isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    @Published var color: String
    
    init(todoItem: TodoItem) {
        self.id = todoItem.id
        self.text = todoItem.text
        self.priority = todoItem.priority
        self.deadline = todoItem.deadline
        self.isDone = todoItem.isDone
        self.createdOn = todoItem.createdOn
        self.updatedOn = todoItem.updatedOn
        self.color = todoItem.color
    }
}
