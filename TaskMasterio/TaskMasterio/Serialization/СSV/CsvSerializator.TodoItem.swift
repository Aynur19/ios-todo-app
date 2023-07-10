//
//  CsvSerializator.TodoItem.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

final class TodoItemCsvSerializator: CsvSerializator {    
    typealias Element = TodoItem
    
    static func serialize(object: TodoItem) -> String {
        var fields = [String]()
        let empty = String()
        
        fields.append(object.id.quote())
        fields.append(object.text.quote())
        
        if object.priority != .medium {
            fields.append(object.priority.rawValue)
        } else {
            fields.append(empty)
        }
        
        if let deadlineTime = object.deadline?.datetime {
            fields.append(String(deadlineTime))
        } else {
            fields.append(empty)
        }
        
        fields.append(String(object.isDone))
        fields.append(String(object.createdOn.datetime))
        
        if let updatedOnTime = object.updatedOn?.datetime {
            fields.append(String(updatedOnTime))
        } else {
            fields.append(empty)
        }
        
        return fields.joined(separator: csvSeparator.rawValue).appending(csvSeparator.rawValue)
    }
    
    static func deserialize(data: String) -> TodoItem? {
        guard !data.isEmpty else { return nil }
        
        let fieldsStr: [String?] = data.split(separator: "\"", omittingEmptySubsequences: false).map({ String($0) })
        
        guard fieldsStr.count >= 5,
              let idCsv = getId(data: fieldsStr[1]),
              let textCsv = fieldsStr[3]
        else { return nil }
        
        guard let fieldsDiff = fieldsStr.last??.split(separator: ";", omittingEmptySubsequences: false).map({ String($0) }),
              fieldsDiff.count > 5
        else { return nil }
        
        guard let priorityCsv = getPriority(data: fieldsDiff[1]) else { return nil }
        
        let deadlineCsv = getDate(data: fieldsDiff[2])
        guard deadlineCsv.isValid else { return nil }
        
        guard let isDoneCsv = getBool(data: fieldsDiff[3]) else { return nil }
        
        let createdOnCsv = getDate(data: fieldsDiff[4])
        guard createdOnCsv.isValid, let createdOnResult = createdOnCsv.result else { return nil }
        
        let updatedOnCsv = getDate(data: fieldsDiff[5])
        guard updatedOnCsv.isValid else { return nil }
        
        return TodoItem.Element(id: idCsv, text: textCsv, priority: priorityCsv, deadline: deadlineCsv.result,
                                isDone: isDoneCsv, createdOn: createdOnResult, updatedOn: updatedOnCsv.result)
    }
    
    static func getHeaders() -> String {
        let separator = CsvSeparator.semicolon.rawValue
        let fields = [TodoItem.Keys.id, TodoItem.Keys.text, TodoItem.Keys.priority, TodoItem.Keys.deadline,
                      TodoItem.Keys.isDone, TodoItem.Keys.createdOn, TodoItem.Keys.updatedOn]
        return fields.joined(separator: separator).appending(separator)
    }
    
    static private func getId(data: String?) -> String? {
        guard let id = data, UUID(uuidString: id) != nil else { return nil }
        return id
    }
    
    static func getPriority(data: String?) -> Priority? {
        if let priorityData = data, !priorityData.isEmpty {
            guard let priorityValue = Priority.init(rawValue: priorityData) else { return nil }
            return priorityValue
        }
        
        return .medium
    }
    
    static func getDate(data: String?) -> (isValid: Bool, result: Date?) {
        guard let dateData = data else { return (true, nil) }
        if dateData.isEmpty { return (true, nil) }
        
        guard let dateTime = Int(dateData) else { return (false, nil) }
        return (true, Date(timeIntervalSince1970: TimeInterval(dateTime)))
    }
    
    static func getBool(data: String?) -> Bool? {
        guard let boolData = data else { return nil }
        
        if boolData == "\(false)" {
            return false
        } else if boolData == "\(true)" {
            return true
        }
        
        return nil
    }
}
