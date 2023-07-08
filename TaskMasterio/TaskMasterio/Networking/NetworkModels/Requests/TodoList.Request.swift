//
//  TodoList.Request.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoListRequest: Codable {
    let list: [TodoItemNetworkDto]
    
    init(list: [TodoItemNetworkDto]) {
        self.list = list
    }
}
