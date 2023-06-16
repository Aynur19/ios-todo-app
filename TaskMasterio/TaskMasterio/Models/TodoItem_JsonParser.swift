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
              let taskPriority = getPriority(data: dict[TodoItemKeys.priority.rawValue] as? String)
        else { return nil }
        
        let taskDeadline = getDate(data: dict[TodoItemKeys.deadline.rawValue] as? String)
        let taskUpdatedOn = getDate(data: dict[TodoItemKeys.updatedOn.rawValue] as? String)
        
        guard taskDeadline.isValid, taskUpdatedOn.isValid else { return nil }
        let createdOnValue = Date(timeIntervalSince1970: TimeInterval(dictCreatedOn))
        
        return TodoItem(id: taskId, text: dictText, priority: taskPriority, deadline: taskDeadline.result,
                        isDone: dictIsDone, createdOn: createdOnValue, updatedOn: taskUpdatedOn.result)
    }
}
