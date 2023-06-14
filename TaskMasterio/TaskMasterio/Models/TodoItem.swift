//
//  TodoItem.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import Foundation

enum Priority: String {
    case high
    case medium
    case low
}

struct TodoItem {
    let id: String
    let text: String
    let priority: Priority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    
    init(id: String = UUID().uuidString, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
}

extension TodoItem {
    var json: Any {
        var data = [String: Any]()
        data["id"] = id
        data["text"] = text
        
        if priority != .medium {
            data["priority"] = "\(priority)"
        }

        if deadline != nil {
            data["deadline"] = Int(deadline!.timeIntervalSince1970)
        }

        data["isDone"] = isDone
        data["createdOn"] = Int(createdOn.timeIntervalSince1970)
        
        if updatedOn != nil {
            data["updatedOn"] = Int(updatedOn!.timeIntervalSince1970)
        } else {
            data["updatedOn"] = nil
        }
        
        return data
    }
    
    static func parse(json: Any) -> TodoItem? {
        let jsonDict: Any?
        
        if let jsonObject = json as? Data {
            jsonDict = try? JSONSerialization.jsonObject(with: jsonObject)
        } else {
            jsonDict = json as? [String: Any]
        }
        
        guard let dict = jsonDict as? [String: Any] else { return nil }
        
        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String,
              let createdOn = (dict["createdOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        else { return nil }
        
        let priority = (dict["priority"] as? String).flatMap({ Priority.init(rawValue: $0) }) ?? .medium
        let deadline = (dict["deadline"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        let isDone = (dict["isDone"] as? Bool) ?? false
        let updatedOn = (dict["updatedOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        
        return TodoItem(id: id, text: text, priority: priority, deadline: deadline, isDone: isDone, createdOn: createdOn, updatedOn: updatedOn)
    }
}
