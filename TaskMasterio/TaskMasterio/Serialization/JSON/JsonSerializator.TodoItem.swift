//
//  JsonSerializationStrategy.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

final class TodoItemJsonSerializator: JsonSerializator {
    typealias Element = TodoItem
    
    static func serialize(object: TodoItem) -> Any {
        var data = [String: Any]()
        data[TodoItem.Keys.id] = object.id
        data[TodoItem.Keys.text] = object.text
        data[TodoItem.Keys.priority] = object.priority != .medium ? object.priority.rawValue : nil
        data[TodoItem.Keys.deadline] = object.deadline?.datetime
        data[TodoItem.Keys.isDone] = object.isDone
        data[TodoItem.Keys.createdOn] = object.createdOn.datetime
        data[TodoItem.Keys.updatedOn] = object.updatedOn?.datetime
        
        return data
    }
    
    static func deserialize(data: Any) -> TodoItem? {
        guard let dict = data as? [String: Any],
              let dictId = dict[TodoItem.Keys.id] as? String,
              let dictText = dict[TodoItem.Keys.text] as? String,
              let dictCreatedOn = dict[TodoItem.Keys.createdOn] as? Int,
              let dictIsDone = dict[TodoItem.Keys.isDone] as? Bool
        else { return nil }
        
        guard UUID(uuidString: dictId) != nil,
              let dictPriority = getPriority(data: dict)
        else { return nil }
        
        var deadlineValue: Date?
        if dict[TodoItem.Keys.deadline] == nil {
            deadlineValue = nil
        } else {
            guard let dictDeadline = getOptionalDateJson(data: dict, key: TodoItem.Keys.deadline)
            else { return nil}
            deadlineValue = dictDeadline
        }
        
        var updatedOnValue: Date?
        if dict[TodoItem.Keys.updatedOn] == nil {
            updatedOnValue = nil
        } else {
            guard let dictUpdatedOn = getOptionalDateJson(data: dict, key: TodoItem.Keys.updatedOn)
            else { return nil}
            updatedOnValue = dictUpdatedOn
        }
        
        let createdOnValue = Date(timeIntervalSince1970: TimeInterval(dictCreatedOn))
        return TodoItem(id: dictId, text: dictText, priority: dictPriority, deadline: deadlineValue,
                        isDone: dictIsDone, createdOn: createdOnValue, updatedOn: updatedOnValue)
    }
    
    static private func getPriority(data: [String: Any]) -> Priority? {
        if data[TodoItem.Keys.priority] == nil { return .medium }
        else {
            if let priorityData = data[TodoItem.Keys.priority] as? String {
                guard let priorityValue = Priority.init(rawValue: priorityData) else { return nil }
                return priorityValue
            }
            else { return nil }
        }
    }
    
    static private func getOptionalDateJson(data: [String: Any], key: String) -> Date? {
        guard let dateData = data[key] as? Int else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(dateData))
    }
}
