//
//  JsonParseTestsData.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 05.07.2023.
//

import Foundation

struct JsonParseTestsData {
    private static let id = TestsData.id
    private static let id2 = TestsData.id2
    
    static let idInvalid: [[String: Any]] = [
        ["id": 1, "text": "id is Int()", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": false, "text": "id is boolean", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": Date(), "text": "id Date()", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": 1.5, "text": "id is Double()", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": [String: Any](), "text": "id is [String: Any]()", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "", "text": "id is empty string", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "sajdnaksfnklnckzjnvkzjnd", "text": "id is short string", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "sajdnaksfnklncsdjnskjnksncljasnvckjskzjnvkzjn", "text": "id is long string", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["text": "id undefined", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000]
    ]
    
    static let idValid: [[String: Any]] = [
        ["id": id, "text": "id valid", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id2, "text": "id valid 2", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000]
    ]
    
    static let textInvalid: [[String: Any]] = [
        ["id": id, "text": 1, "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": false, "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": Date(), "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": 1.5, "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": [String: Any](), "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000]
    ]
    
    static let textValid: [[String: Any]] = [
        ["id": id, "text": "text valid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "   ", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000]
    ]
    
    static let priorityInvalid: [[String: Any]] = [
        ["id": id, "text": "priority invalid 1", "priority": 8, "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 2", "priority": "hard", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 3", "priority": "   ", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 4", "priority": "", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 5", "priority": false, "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 6", "priority": Date(), "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 7", "priority": 1.5, "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 8", "priority": [String: Any](), "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let priorityValid: [[String: Any]] = [
        ["id": id, "text": "priority valid 1", "priority": "medium", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 2", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 3", "priority": "high", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 4", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let deadlineInvalid: [[String: Any]] = [
        ["id": id, "text": "deadline invalid 1", "priority": "low", "deadline": "168655000",
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 2", "priority": "high", "deadline": "   ",
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 3", "priority": "high", "deadline": "",
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 4", "priority": "low", "deadline": false,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 5", "priority": "high", "deadline": Date(),
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 6", "priority": "low", "deadline": [String: Any](),
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 7", "priority": "high", "deadline": 168655000.55,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let deadlineValid: [[String: Any]] = [
        ["id": id, "text": "deadline valid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline valid 2", "priority": "low",
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let isDoneInvalid: [[String: Any]] = [
        ["id": id, "text": "isDone invalid 1", "priority": "low", "deadline": 168655000,
         "isDone": "false", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 2", "priority": "low", "deadline": 168655000,
         "isDone": "  ", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 3", "priority": "low", "deadline": 168655000,
         "isDone": "", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 4", "priority": "low", "deadline": 168655000,
         "isDone": 1, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 5", "priority": "low", "deadline": 168655000,
         "isDone": 1.5, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 6", "priority": "low", "deadline": 168655000,
         "isDone": Date(), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 7", "priority": "low", "deadline": 168655000,
         "isDone": [String: Any](), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 8", "priority": "low", "deadline": 168655000,
         "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let isDoneValid: [[String: Any]] = [
        ["id": id, "text": "isDone valid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone valid 2", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let createdOnInvalid: [[String: Any]] = [
        ["id": id, "text": "createdOn invalid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": "168655000", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 2", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": "   ", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 3", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": "", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 4", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": Date(), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 5", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": false, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 6", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": [String: Any](), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 7", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000.55, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 8", "priority": "low", "deadline": 168655000,
         "isDone": true, "updatedOn": 168655000],
    ]
    
    static let createdOnValid: [[String: Any]] = [
        ["id": id, "text": "createdOn valid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let updatedOnInvalid: [[String: Any]] = [
        ["id": id, "text": "updatedOn invalid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": "168655000"],
        ["id": id, "text": "updatedOn invalid 2", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": "   "],
        ["id": id, "text": "updatedOn invalid 3", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": ""],
        ["id": id, "text": "updatedOn invalid 4", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": Date()],
        ["id": id, "text": "updatedOn invalid 5", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": false],
        ["id": id, "text": "updatedOn invalid 6", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": [String: Any]()],
        ["id": id, "text": "updatedOn invalid 7", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000.55],
    ]
    
    static let updatedOnValid: [[String: Any]] = [
        ["id": id, "text": "test, updatedOn valid 1", "priority": "low", "deadline": 168655000,
         "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test, updatedOn valid 2", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test, updatedOn valid 3", "priority": "low", "deadline": 168655000,
         "isDone": true, "createdOn": 168655000],
    ]
}
