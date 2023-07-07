//
//  NetworkDtoMapping.Errors.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

enum NetworkDtoMapping: LocalizedError {
    
    case failedMappingFromTodoItem(todoItem: TodoItem)
    case failedMappingToTodoItem(todoItemNetworkDto: TodoItemNetworkDto)
    
    var errorDescription: String? {
        switch self {
        case .failedMappingFromTodoItem(let todoItem):
            return "ERROR: Error mapping TodoItem model to TodoItemNetworkDto model!" +
            "\n  TodoItem: \(todoItem)"
        case .failedMappingToTodoItem(let todoItemNetworkDto):
            return "ERROR: Error mapping TodoItemNetworkDto model to TodoItem model!" +
            "\n  TodoItemNetworkDto: \(todoItemNetworkDto)"
        }
    }
}
