//
//  TodoList.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoList {
    var items: [TodoItem]
    var revision: Int
    var isDirty: Bool
    var lastUpdatedBy: String
    var lastUpdatedOn: Int
}
