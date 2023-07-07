//
//  TodoItem.Mapper.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoItemMapper {
    static func mapToTodoItem(from dto: TodoItemNetworkDto) throws -> TodoItem {
        guard let priority = Priority.getPriority(networkValue: dto.priority) else {
            throw NetworkDtoMapping.failedMappingToTodoItem(todoItemNetworkDto: dto)
        }
        
        var deadline: Date? = nil
        if let deadlineInterval = dto.deadline {
            deadline = Date(timeIntervalSince1970: TimeInterval(deadlineInterval))
        }
        
        let createdOn = Date(timeIntervalSince1970: TimeInterval(dto.createdOn))
        let updatedOn = Date(timeIntervalSince1970: TimeInterval(dto.updatedOn))
        
        return TodoItem(id: dto.id,
                        text: dto.text,
                        priority: priority,
                        deadline: deadline,
                        isDone: dto.isDone,
                        createdOn: createdOn,
                        updatedOn: updatedOn)
    }
    
    static func mapToTodoList(from response: TodoListResponse) throws -> [TodoItem] {
        var result = [TodoItem]()
        
        for item in response.list {
            let todo = try mapToTodoItem(from: item)
            result.append(todo)
        }
        
        return result
    }
}
