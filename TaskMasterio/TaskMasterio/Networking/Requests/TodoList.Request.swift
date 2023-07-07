//
//  TodoList.Request.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoListRequest: Codable {
//    var status: String
    var list: [TodoItemNetworkDto]
    
    init(list: [TodoItemNetworkDto]) {
//        self.status = status
        self.list = list
    }
}
