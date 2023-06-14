//
//  ToDoItemTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import XCTest
@testable import TaskMasterio

final class ToDoItemTests: XCTestCase {
    var task: TodoItem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        task = nil
        try super.tearDownWithError()
    }
    
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
}
