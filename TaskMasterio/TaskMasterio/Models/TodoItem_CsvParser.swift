//
//  TodoItem_CsvParser.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 17.06.2023.
//

import Foundation

extension TodoItem: CsvParser {
    static private var _separator: CsvSeparator = .semicolon
    static var separator: CsvSeparator { get { _separator } }
    
    var csv: String {
        var fields = [String]()
        let empty = String()
        
        fields.append(id.quote())
        fields.append(text.quote())
        
        if priority != .medium { fields.append(priority.rawValue) }
        else { fields.append(empty) }
        
        if let deadlineTime = deadline?.datetime { fields.append(String(deadlineTime)) }
        else { fields.append(empty) }
        
        fields.append(String(isDone))
        fields.append(String(createdOn.datetime))
        
        if let updatedOnTime = updatedOn?.datetime { fields.append(String(updatedOnTime)) }
        else { fields.append(empty) }
        
        return fields.joined(separator: Self.separator.rawValue).appending(Self.separator.rawValue)
    }
    
    static func parse(csv: String) -> TodoItem? {
        guard !csv.isEmpty else { return nil }
        
        let fieldsStr: [String?] = csv.split(separator: "\"", omittingEmptySubsequences: false).map({ String($0) })
        
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
        let fields = [TodoItemKeys.id.rawValue, TodoItemKeys.text.rawValue, TodoItemKeys.priority.rawValue,
                      TodoItemKeys.deadline.rawValue, TodoItemKeys.isDone.rawValue, TodoItemKeys.createdOn.rawValue,
                      TodoItemKeys.updatedOn.rawValue]
        return fields.joined(separator: separator).appending(separator)
    }
}
