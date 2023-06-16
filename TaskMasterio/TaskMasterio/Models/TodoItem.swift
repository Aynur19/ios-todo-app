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
        
        if let jsonDeadline = deadline {
            data["deadline"] = Int(jsonDeadline.timeIntervalSince1970)
        }
        
        data["isDone"] = isDone
        data["createdOn"] = Int(createdOn.timeIntervalSince1970)
        
        if let jsonUpdatedOn = updatedOn {
            data["updatedOn"] = Int(jsonUpdatedOn.timeIntervalSince1970)
        } else {
            data["updatedOn"] = nil
        }
        
        return data
    }
    
    static func parse(json: Any) -> TodoItem? {
        guard let dict = json as? [String: Any] else { return nil }
        
        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String,
              let createdOn = (dict["createdOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        else { return nil }
        
        var priority: Priority
        if dict["priority"] != nil {
            guard let priorityValue = (dict["priority"] as? String).flatMap({ Priority.init(rawValue: $0) })
            else { return nil }
            
            priority = priorityValue
        } else {
            priority = Priority.medium
        }
        
        let deadline = (dict["deadline"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        if dict["deadline"] != nil, deadline == nil { return nil }
        
        guard let isDone = (dict["isDone"] as? Bool) else { return nil }
        
        let updatedOn = (dict["updatedOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        if dict["updatedOn"] != nil, updatedOn == nil { return nil }
        
        return TodoItem(id: id, text: text, priority: priority, deadline: deadline, isDone: isDone,
                        createdOn: createdOn, updatedOn: updatedOn)
    }
}

extension TodoItem: CsvParser {
    static func parse(csv: String) -> TodoItem? {
        return nil
    }
    
    var csv: String {
        return ""
    }
}
