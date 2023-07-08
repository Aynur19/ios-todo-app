//
//  TodoList.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct TodoList {
    var items = [TodoItem]()
    var revision = 0
    var isDirty = false
    var lastUpdatedBy = ""
    var lastUpdatedOn = 0
}

extension TodoList: JsonParser {
    var json: Any {
        var data = [String: Any]()
        data["revision"] = revision
        data["isDirty"] = isDirty
        data["lastUpdatedBy"] = lastUpdatedBy
        data["lastUpdatedOn"] = lastUpdatedOn
        data["items"] = items.map { $0.json }
        
        return data
    }
    
    static func parse(json: Any) -> TodoList? {
        guard let dict = json as? [String: Any],
              let revision = dict["revision"] as? Int,
              let isDirty = dict["isDirty"] as? Bool,
              let lastUpdatedBy = dict["lastUpdatedBy"] as? String,
              let lastUpdatedOn = dict["lastUpdatedOn"] as? Int,
              let dictItems = dict["items"] as? [Any]
        else { return nil }
        
        var items = [TodoItem]()
        for dictItem in dictItems {
            if let item = TodoItem.parse(json: dictItem) {
                items.append(item)
            }
        }
        
        return TodoList(items: items, revision: revision, isDirty: isDirty, lastUpdatedBy: lastUpdatedBy, lastUpdatedOn: lastUpdatedOn)
    }
}
