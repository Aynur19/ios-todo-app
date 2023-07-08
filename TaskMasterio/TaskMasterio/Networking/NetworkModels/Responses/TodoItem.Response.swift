//
//  TodoItem.Response.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoItemResponse: Codable {
    var status: String
    var item: TodoItemNetworkDto
    var revision: Int
    
    private enum CodingKeys: String, CodingKey {
        case status
        case item = "element"
        case revision
    }
}
