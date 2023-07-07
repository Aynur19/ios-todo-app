//
//  TodoList.NetworkDTO.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoListNetworkDto: Codable {
    var list: [TodoItemNetworkDto]
}
