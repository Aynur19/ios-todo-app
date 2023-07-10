//
//  TodoItem.Priority.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

enum TodoItemPriority: String {
    case high
    case medium
    case low
    
    var index: Int {
        switch self {
        case .low: return 0
        case .medium: return 1
        case .high: return 2
        }
    }
    
    var networkValue: String {
        switch self {
        case .low: return "low"
        case .medium: return "basic"
        case .high: return "important"
        }
    }
    
    static func getPriority(_ priorityValue: Int?) -> TodoItemPriority? {
        guard let value = priorityValue else { return nil }
        
        switch value {
        case 0: return .low
        case 1: return .medium
        case 2: return .high
        default: return nil
        }
    }
    
    static func getPriority(networkValue: String) -> TodoItemPriority? {
        switch networkValue {
        case "low": return .low
        case "basic": return .medium
        case "important": return .high
        default: return nil
        }
    }
}
