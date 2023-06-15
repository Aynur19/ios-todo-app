//
//  TodoItemTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItemTests: XCTestCase {
    var task: TodoItem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        task = nil
        try super.tearDownWithError()
    }
    
    static let id = "A5A600C6-9B8F-4B36-AD55-F49B3D55C975"
    static let createdOn = Date(timeIntervalSince1970: TimeInterval(168655000))
    static let updatedOn = Date(timeIntervalSince1970: TimeInterval(168655000))
    static let deadline = Date(timeIntervalSince1970: TimeInterval(168655000))
    
    let testCases_DeadlineAndUpdatedOn_IsNil: [(text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("test 1", .medium, nil, false, createdOn, nil),
        ("test 2", .high,   nil, false, createdOn, nil),
        ("test 3", .low,    nil, false, createdOn, nil),
        
        ("test 4", .medium, nil, true, createdOn, nil),
        ("test 5", .high,   nil, true, createdOn, nil),
        ("test 6", .low,    nil, true, createdOn, nil),
    ]
    
    let testCases_UpdatedOn_IsNil: [(text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("test 7", .medium, deadline, false, createdOn, nil),
        ("test 8", .high,   deadline, false, createdOn, nil),
        ("test 9", .low,    deadline, false, createdOn, nil),
        
        ("test 10", .medium, deadline, true, createdOn, nil),
        ("test 11", .high,   deadline, true, createdOn, nil),
        ("test 12", .low,    deadline, true, createdOn, nil),
    ]
    
    let testCases_Deadline_IsNil: [(text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("test 13", .medium, nil, false, createdOn, updatedOn),
        ("test 14", .high,   nil, false, createdOn, updatedOn),
        ("test 15", .low,    nil, false, createdOn, updatedOn),
        
        ("test 16", .medium, nil, true, createdOn, updatedOn),
        ("test 17", .high,   nil, true, createdOn, updatedOn),
        ("test 18", .low,    nil, true, createdOn, updatedOn),
        
    ]
    
    let testCases_Filled: [(text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        
        ("test 19", .medium, deadline, false, createdOn, updatedOn),
        ("test 20", .high,   deadline, false, createdOn, updatedOn),
        ("test 21", .low,    deadline, false, createdOn, updatedOn),
        
        ("test 22", .medium, deadline, true, createdOn, updatedOn),
        ("test 23", .high,   deadline, true, createdOn, updatedOn),
        ("test 24", .low,    deadline, true, createdOn, updatedOn),
    ]
    
    
    func testInit_IdGenerated() throws {
        for testCases in [testCases_DeadlineAndUpdatedOn_IsNil, testCases_Deadline_IsNil, testCases_UpdatedOn_IsNil, testCases_Filled] {
            for testCase in testCases {
                task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
                
                XCTAssertNotNil(task)
                XCTAssertNotNil(task.id)
                XCTAssertEqual(task.text, testCase.text)
                XCTAssertEqual(task.priority, testCase.priority)
                XCTAssertEqual(task.deadline, testCase.deadline)
                XCTAssertEqual(task.isDone, testCase.isDone)
                XCTAssertEqual(task.createdOn, testCase.createdOn)
                XCTAssertEqual(task.updatedOn, testCase.updatedOn)
            }
        }
    }
    
    func testInit_IdPassed() throws {
        for testCases in [testCases_DeadlineAndUpdatedOn_IsNil, testCases_Deadline_IsNil, testCases_UpdatedOn_IsNil, testCases_Filled] {
            for testCase in testCases {
                let id = UUID().uuidString
                task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
                
                XCTAssertNotNil(task)
                XCTAssertEqual(task.id, id)
                XCTAssertEqual(task.text, testCase.text)
                XCTAssertEqual(task.priority, testCase.priority)
                XCTAssertEqual(task.deadline, testCase.deadline)
                XCTAssertEqual(task.isDone, testCase.isDone)
                XCTAssertEqual(task.createdOn, testCase.createdOn)
                XCTAssertEqual(task.updatedOn, testCase.updatedOn)
            }
        }
    }
    
    func testJson_IdGenerated_DeadlineAndUpdatedOn_IsNil() {
        for testCase in testCases_DeadlineAndUpdatedOn_IsNil {
            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let updatedOn: Int? = nil
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, task.id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertNil(json!["deadline"])
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdPassed_DeadlineAndUpdatedOn_IsNil() {
        for testCase in testCases_DeadlineAndUpdatedOn_IsNil {
            let id = UUID().uuidString
            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let updatedOn: Int? = nil
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertNil(json!["deadline"])
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdGenerated_UpdatedOn_IsNil() {
        for testCase in testCases_UpdatedOn_IsNil {
            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let updatedOn: Int? = nil
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, task.id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdPassed_UpdatedOn_IsNil() {
        for testCase in testCases_UpdatedOn_IsNil {
            let id = UUID().uuidString
            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let updatedOn: Int? = nil
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdGenerated_Deadline_IsNil() {
        for testCase in testCases_Deadline_IsNil {
            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, task.id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertNil(json!["deadline"])
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdPassed_Deadline_IsNil() {
        for testCase in testCases_Deadline_IsNil {
            let id = UUID().uuidString
            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertNil(json!["deadline"])
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdGenerated_Filled() {
        for testCase in testCases_Filled {
            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, task.id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    func testJson_IdPassed_Filled() {
        for testCase in testCases_Filled {
            let id = UUID().uuidString
            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json!["id"] as? String, id)
            XCTAssertEqual(json!["text"] as? String, testCase.text)
            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
            
            if testCase.priority == .medium {
                XCTAssertNil(json!["priority"])
            } else {
                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
            }
        }
    }
    
    
    
    let testCases_Parse_Id_Invalid: [[String: Any]] = [
        ["id": 1, "text": "id invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": false, "text": "id invalid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": Date(), "text": "id invalid 3", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": 1.5 , "text": "id invalid 4", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": [String: Any](), "text": "id invalid 5", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["text": "id invalid 6", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Id_Valid: [[String: Any]] = [
        ["id": id, "text": "id valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "id", "text": "id valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "", "text": "id valid 3", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "   ", "text": "id valid 4", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Text_Invalid: [[String: Any]] = [
        ["id": id, "text": 1, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": false, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": Date(), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": 1.5, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": [String: Any](), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Text_Valid: [[String: Any]] = [
        ["id": id, "text": "text valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "   ", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Priority_Invalid: [Any] = [
        ["id": id, "text": "priority invalid 1", "priority": 8, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 2", "priority": "hard", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 3", "priority": "   ", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 4", "priority": "", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 5", "priority": false, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 6", "priority": Date(), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 7", "priority": 1.5, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 8", "priority": [String: Any](), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Priority_Valid: [Any] = [
        ["id": id, "text": "priority valid 1", "priority": "medium", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 3", "priority": "high", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 4", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Deadline_Invalid: [Any] = [
        ["id": id, "text": "deadline invalid 1", "priority": "low", "deadline": "168655000", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 2", "priority": "high", "deadline": "   ", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 3", "priority": "high", "deadline": "", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 4", "priority": "low", "deadline": false, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 5", "priority": "high", "deadline": Date(), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 6", "priority": "low", "deadline": [String: Any](), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 7", "priority": "high", "deadline": 168655000.55, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_Deadline_Valid: [Any] = [
        ["id": id, "text": "deadline valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline valid 2", "priority": "low", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_IsDone_Invalid: [Any] = [
        ["id": id, "text": "isDone invalid 1", "priority": "low", "deadline": 168655000, "isDone": "false", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 2", "priority": "low", "deadline": 168655000, "isDone": "  ", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 3", "priority": "low", "deadline": 168655000, "isDone": "", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 4", "priority": "low", "deadline": 168655000, "isDone": 1, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 5", "priority": "low", "deadline": 168655000, "isDone": 1.5, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 6", "priority": "low", "deadline": 168655000, "isDone": Date(), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 7", "priority": "low", "deadline": 168655000, "isDone": [String: Any](), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 8", "priority": "low", "deadline": 168655000, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_IsDone_Valid: [Any] = [
        ["id": id, "text": "isDone valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone valid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_CreatedOn_Invalid: [Any] = [
        ["id": id, "text": "createdOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": "168655000", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "   ", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": Date(), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": false, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": [String: Any](), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000.55, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 8", "priority": "low", "deadline": 168655000, "isDone": true, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_CreatedOn_Valid: [Any] = [
        ["id": id, "text": "createdOn valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    let testCases_Parse_UpdatedOn_Invalid: [Any] = [
        ["id": id, "text": "updatedOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": "168655000"],
        ["id": id, "text": "updatedOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": "   "],
        ["id": id, "text": "updatedOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": ""],
        ["id": id, "text": "updatedOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": Date()],
        ["id": id, "text": "updatedOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": false],
        ["id": id, "text": "updatedOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": [String: Any]()],
        ["id": id, "text": "updatedOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000.55],
    ]
    
    let testCases_Parse_UpdatedOn_Valid: [Any] = [
        ["id": id, "text": "test", "updatedOn valid 1": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test", "updatedOn valid 2": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test", "updatedOn valid 3": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000],
    ]
    
    func testParse_TofoItem_IsNil() {
        for testCases in [testCases_Parse_Id_Invalid, testCases_Parse_Text_Invalid, testCases_Parse_Deadline_Invalid, testCases_Parse_Priority_Invalid, testCases_Parse_IsDone_Invalid, testCases_Parse_CreatedOn_Invalid, testCases_Parse_UpdatedOn_Invalid] {
            for testCase in testCases {
                let task = TodoItem.parse(json: testCase)
                
                XCTAssertNil(task)
            }
        }
    }
    
    func testParse_TofoItem_IsNotNil() {
        for testCases in [testCases_Parse_Id_Valid, testCases_Parse_Text_Valid, testCases_Parse_Deadline_Valid, testCases_Parse_Priority_Valid, testCases_Parse_IsDone_Valid, testCases_Parse_CreatedOn_Valid, testCases_Parse_UpdatedOn_Valid] {
            for testCase in testCases {
                let task = TodoItem.parse(json: testCase)
                
                let json = testCase as? [String: Any]
                
                XCTAssertNotNil(task)
                XCTAssertNotNil(json)
                XCTAssertEqual(task!.id, json!["id"] as? String)
                XCTAssertEqual(task!.text, json!["text"] as? String)
                
                if json!["priority"] == nil {
                    XCTAssertEqual(task!.priority, Priority.medium)
                } else {
                    XCTAssertEqual(task!.priority, Priority.init(rawValue: (json!["priority"] as? String ?? "")))
                }
                
                XCTAssertEqual(task!.isDone, json!["isDone"] as? Bool)
                
                if json!["deadline"] == nil {
                    XCTAssertNil(task!.deadline)
                } else {
                    XCTAssertEqual(task!.deadline, Date(timeIntervalSince1970: TimeInterval((json!["deadline"] as? Int ?? 0))))
                }
                
                XCTAssertEqual(task!.createdOn, Date(timeIntervalSince1970: TimeInterval((json!["createdOn"] as? Int ?? 0))))
                
                if json!["updatedOn"] == nil {
                    XCTAssertNil(task!.updatedOn)
                } else {
                    XCTAssertEqual(task!.updatedOn, Date(timeIntervalSince1970: TimeInterval((json!["updatedOn"] as? Int ?? 0))))
                }
            }
        }
    }
}
