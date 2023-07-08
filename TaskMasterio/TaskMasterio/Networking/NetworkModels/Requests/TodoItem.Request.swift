//
//  TodoItem.Request.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 08.07.2023.
//

import Foundation

struct TodoItemRequest: Codable {
    var element: TodoItemNetworkDto
    
    init(element: TodoItemNetworkDto) {
        self.element = element
    }
}
