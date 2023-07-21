//
//  TodoItem.Priority.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 21.07.2023.
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
    
    static func getPriority(_ priorityValue: Int?) -> TodoItemPriority? {
        guard let value = priorityValue else { return nil }
        
        switch value {
        case 0: return .low
        case 1: return .medium
        case 2: return .high
        default: return nil
        }
    }
}
