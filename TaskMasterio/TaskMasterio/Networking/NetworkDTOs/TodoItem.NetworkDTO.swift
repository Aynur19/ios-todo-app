//
//  TodoItem.NetworkDTO.swift
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
}
