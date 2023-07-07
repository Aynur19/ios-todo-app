//
//  TodoItem.NetworkDto.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoItemNetworkDto: Codable {
    var id: String
    var text: String
    var priority: String
    var deadline: Int?
    var isDone: Bool
    var createdOn: Int
    var updatedOn: Int
    var color: String
    var lastUpdatedBy: String
    
    init(todoItem: TodoItem) {
        id = todoItem.id
        text = todoItem.text
        priority = todoItem.priority.networkValue
        deadline = todoItem.deadline?.datetime
        isDone = todoItem.isDone
        createdOn = todoItem.createdOn.datetime
        updatedOn = todoItem.updatedOn?.datetime ?? createdOn
        color = "#FFFFFF"
        lastUpdatedBy = "default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.priority = try container.decode(String.self, forKey: .priority)
        self.deadline = try container.decodeIfPresent(Int.self, forKey: .deadline)
        self.isDone = try container.decode(Bool.self, forKey: .isDone)
        self.createdOn = try container.decode(Int.self, forKey: .createdOn)
        self.updatedOn = try container.decode(Int.self, forKey: .updatedOn)
        self.color = try container.decode(String.self, forKey: .color) ?? "#FFFFFF"
        self.lastUpdatedBy = try container.decode(String.self, forKey: .lastUpdatedBy)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case priority = "importance"
        case deadline
        case isDone = "done"
        case createdOn = "created_at"
        case updatedOn = "changed_at"
        case color
        case lastUpdatedBy = "last_updated_by"
    }
    
    func toTodoItem() throws -> TodoItem {
        guard let priority = Priority.getPriority(networkValue: priority) else {
            throw NetworkDtoMapping.failedMappingToTodoItem(todoItemNetworkDto: self)
        }
        
        var deadline: Date? = nil
        if let deadlineInterval = self.deadline {
            deadline = Date(timeIntervalSince1970: TimeInterval(deadlineInterval))
        }
        
        let createdOn = Date(timeIntervalSince1970: TimeInterval(self.createdOn))
        let updatedOn = Date(timeIntervalSince1970: TimeInterval(self.updatedOn))
        
        return TodoItem(id: id,
                        text: text,
                        priority: priority,
                        deadline: deadline,
                        isDone: isDone,
                        createdOn: createdOn,
                        updatedOn: updatedOn)
    }
}
