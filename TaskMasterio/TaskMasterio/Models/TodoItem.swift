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
    
    var index: Int {
        switch self {
        case .low:
            return 0
        case .medium:
            return 1
        case .high:
            return 2
        }
    }
    
    static func getPriority(_ priorityValue: Int?) -> Priority? {
        guard let value = priorityValue else { return nil }
        
        switch value {
        case 0: return Priority.low
        case 1: return Priority.medium
        case 2: return Priority.high
        default: return nil
        }
    }
}

struct TodoItem {
    static let idLenght = 36
    
    let id: String
    let text: String
    let priority: Priority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    
    init(
        id: String = UUID().uuidString,
        text: String,
        priority: Priority,
        deadline: Date? = nil,
        isDone: Bool = false,
        createdOn: Date = Date(),
        updatedOn: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
    
    enum Keys {
        static let id = "id"
        static let text = "text"
        static let priority = "priority"
        static let deadline = "deadline"
        static let isDone = "isDone"
        static let createdOn = "createdOn"
        static let updatedOn = "updatedOn"
    }
}

extension TodoItem {
    static func getId(data: String?) -> String? {
        guard let idData = data, idData.count == idLenght else { return nil }
        return idData
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
        
        if boolData == "\(false)" { return false }
        else if boolData == "\(true)" { return true }
        
        return nil
    }
}
