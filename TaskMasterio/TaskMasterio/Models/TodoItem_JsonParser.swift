//
//  TodoItem.JsonParser.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import Foundation


extension TodoItem: JsonParser {
    var json: Any {
        var data = [String: Any]()
        data[TodoItemKeys.id.rawValue] = id
        data[TodoItemKeys.text.rawValue] = text
        data[TodoItemKeys.priority.rawValue] = priority != .medium ? priority.rawValue : nil
        data[TodoItemKeys.deadline.rawValue] = deadline?.datetime
        data[TodoItemKeys.isDone.rawValue] = isDone
        data[TodoItemKeys.createdOn.rawValue] = createdOn.datetime
        data[TodoItemKeys.updatedOn.rawValue] = updatedOn?.datetime
        
        return data
    }
    
    static func parse(json: Any) -> TodoItem? {
        guard let dict = json as? [String: Any],
              let dictId = dict[TodoItemKeys.id.rawValue] as? String,
              let dictText = dict[TodoItemKeys.text.rawValue] as? String,
              let dictCreatedOn = dict[TodoItemKeys.createdOn.rawValue] as? Int,
              let dictIsDone = dict[TodoItemKeys.isDone.rawValue] as? Bool
        else { return nil }
        
        guard let taskId = getId(data: dictId),
              let dictPriority = getPriorityJson(data: dict)
        else { return nil }
        
        var deadlineValue: Date?
        if dict[TodoItemKeys.deadline.rawValue] == nil {
            deadlineValue = nil
        } else {
            guard let dictDeadline = getOptionalDateJson(data: dict, key: TodoItemKeys.deadline.rawValue)
            else { return nil}
            deadlineValue = dictDeadline
        }
        
        var updatedOnValue: Date?
        if dict[TodoItemKeys.updatedOn.rawValue] == nil {
            updatedOnValue = nil
        } else {
            guard let dictUpdatedOn = getOptionalDateJson(data: dict, key: TodoItemKeys.updatedOn.rawValue)
            else { return nil}
            updatedOnValue = dictUpdatedOn
        }

        let createdOnValue = Date(timeIntervalSince1970: TimeInterval(dictCreatedOn))
        return TodoItem(id: taskId, text: dictText, priority: dictPriority, deadline: deadlineValue,
                        isDone: dictIsDone, createdOn: createdOnValue, updatedOn: updatedOnValue)
    }
    
    static func getPriorityJson(data: [String: Any]) -> Priority? {
        if data[TodoItemKeys.priority.rawValue] == nil { return .medium }
        else {
            if let priorityData = data[TodoItemKeys.priority.rawValue] as? String {
                guard let priorityValue = Priority.init(rawValue: priorityData) else { return nil }
                return priorityValue
            }
            else { return nil }
        }
    }
    
    static func getOptionalDateJson(data: [String: Any], key: String) -> Date? {
        guard let dateData = data[key] as? Int else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(dateData))
    }
}
