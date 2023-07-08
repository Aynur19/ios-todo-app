//
//  TodoList.Response.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoListResponse: Codable {
    var status: String
    var list: [TodoItemNetworkDto]
    var revision: Int
}
