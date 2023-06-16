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
    
    func test_Init_IdGenerated() throws {
        for data in TestsData.testCases_ForInit {
            task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            
            XCTAssertNotNil(task)
            XCTAssertNotNil(task.id)
            XCTAssertEqual(task.text, data.text)
            XCTAssertEqual(task.priority, data.priority)
            XCTAssertEqual(task.deadline, data.deadline)
            XCTAssertEqual(task.isDone, data.isDone)
            XCTAssertEqual(task.createdOn, data.createdOn)
            XCTAssertEqual(task.updatedOn, data.updatedOn)
        }
    }
    
    func test_Init_IdPassed() throws {
        
        for data in TestsData.testCases_ForInit {
            task = TodoItem(id: TestsData.id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
        
            XCTAssertNotNil(task)
            XCTAssertEqual(task.id, TestsData.id)
            XCTAssertEqual(task.text, data.text)
            XCTAssertEqual(task.priority, data.priority)
            XCTAssertEqual(task.deadline, data.deadline)
            XCTAssertEqual(task.isDone, data.isDone)
            XCTAssertEqual(task.createdOn, data.createdOn)
            XCTAssertEqual(task.updatedOn, data.updatedOn)
        }
    }

    
//    func test_Json_IdGenerated_DeadlineAndUpdatedOn_IsNil() {
//        for testCase in testCases_DeadlineAndUpdatedOn_IsNil {
//            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let updatedOn: Int? = nil
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, task.id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertNil(json!["deadline"])
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdPassed_DeadlineAndUpdatedOn_IsNil() {
//        for testCase in testCases_DeadlineAndUpdatedOn_IsNil {
//            let id = UUID().uuidString
//            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let updatedOn: Int? = nil
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertNil(json!["deadline"])
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdGenerated_UpdatedOn_IsNil() {
//        for testCase in testCases_UpdatedOn_IsNil {
//            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let updatedOn: Int? = nil
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, task.id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdPassed_UpdatedOn_IsNil() {
//        for testCase in testCases_UpdatedOn_IsNil {
//            let id = UUID().uuidString
//            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let updatedOn: Int? = nil
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdGenerated_Deadline_IsNil() {
//        for testCase in testCases_Deadline_IsNil {
//            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, task.id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertNil(json!["deadline"])
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdPassed_Deadline_IsNil() {
//        for testCase in testCases_Deadline_IsNil {
//            let id = UUID().uuidString
//            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertNil(json!["deadline"])
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdGenerated_Filled() {
//        for testCase in testCases_Filled {
//            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, task.id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//    func testJson_IdPassed_Filled() {
//        for testCase in testCases_Filled {
//            let id = UUID().uuidString
//            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//
//            let json = task.json as? [String: Any]
//
//            XCTAssertNotNil(json)
//            XCTAssertEqual(json!["id"] as? String, id)
//            XCTAssertEqual(json!["text"] as? String, testCase.text)
//            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
//
//            if testCase.priority == .medium {
//                XCTAssertNil(json!["priority"])
//            } else {
//                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//            }
//        }
//    }
//
//
//
//    let testCases_Parse_Id_Invalid: [[String: Any]] = [
//        ["id": 1, "text": "id invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": false, "text": "id invalid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": Date(), "text": "id invalid 3", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": 1.5 , "text": "id invalid 4", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": [String: Any](), "text": "id invalid 5", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["text": "id invalid 6", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Id_Valid: [[String: Any]] = [
//        ["id": id, "text": "id valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": "id", "text": "id valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": "", "text": "id valid 3", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": "   ", "text": "id valid 4", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Text_Invalid: [[String: Any]] = [
//        ["id": id, "text": 1, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": false, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": Date(), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": 1.5, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": [String: Any](), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Text_Valid: [[String: Any]] = [
//        ["id": id, "text": "text valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "   ", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Priority_Invalid: [Any] = [
//        ["id": id, "text": "priority invalid 1", "priority": 8, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 2", "priority": "hard", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 3", "priority": "   ", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 4", "priority": "", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 5", "priority": false, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 6", "priority": Date(), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 7", "priority": 1.5, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority invalid 8", "priority": [String: Any](), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Priority_Valid: [Any] = [
//        ["id": id, "text": "priority valid 1", "priority": "medium", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority valid 3", "priority": "high", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "priority valid 4", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Deadline_Invalid: [Any] = [
//        ["id": id, "text": "deadline invalid 1", "priority": "low", "deadline": "168655000", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 2", "priority": "high", "deadline": "   ", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 3", "priority": "high", "deadline": "", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 4", "priority": "low", "deadline": false, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 5", "priority": "high", "deadline": Date(), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 6", "priority": "low", "deadline": [String: Any](), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline invalid 7", "priority": "high", "deadline": 168655000.55, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_Deadline_Valid: [Any] = [
//        ["id": id, "text": "deadline valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "deadline valid 2", "priority": "low", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_IsDone_Invalid: [Any] = [
//        ["id": id, "text": "isDone invalid 1", "priority": "low", "deadline": 168655000, "isDone": "false", "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 2", "priority": "low", "deadline": 168655000, "isDone": "  ", "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 3", "priority": "low", "deadline": 168655000, "isDone": "", "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 4", "priority": "low", "deadline": 168655000, "isDone": 1, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 5", "priority": "low", "deadline": 168655000, "isDone": 1.5, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 6", "priority": "low", "deadline": 168655000, "isDone": Date(), "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 7", "priority": "low", "deadline": 168655000, "isDone": [String: Any](), "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone invalid 8", "priority": "low", "deadline": 168655000, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_IsDone_Valid: [Any] = [
//        ["id": id, "text": "isDone valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "isDone valid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_CreatedOn_Invalid: [Any] = [
//        ["id": id, "text": "createdOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": "168655000", "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "   ", "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "", "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": Date(), "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": false, "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": [String: Any](), "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000.55, "updatedOn": 168655000],
//        ["id": id, "text": "createdOn invalid 8", "priority": "low", "deadline": 168655000, "isDone": true, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_CreatedOn_Valid: [Any] = [
//        ["id": id, "text": "createdOn valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//    ]
//
//    let testCases_Parse_UpdatedOn_Invalid: [Any] = [
//        ["id": id, "text": "updatedOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": "168655000"],
//        ["id": id, "text": "updatedOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": "   "],
//        ["id": id, "text": "updatedOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": ""],
//        ["id": id, "text": "updatedOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": Date()],
//        ["id": id, "text": "updatedOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": false],
//        ["id": id, "text": "updatedOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": [String: Any]()],
//        ["id": id, "text": "updatedOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000.55],
//    ]
//
//    let testCases_Parse_UpdatedOn_Valid: [Any] = [
//        ["id": id, "text": "test", "updatedOn valid 1": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "test", "updatedOn valid 2": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
//        ["id": id, "text": "test", "updatedOn valid 3": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000],
//    ]
//
//    func testParse_TodoItem_IsNil() {
//        for testCases in [testCases_Parse_Id_Invalid, testCases_Parse_Text_Invalid, testCases_Parse_Deadline_Invalid, testCases_Parse_Priority_Invalid, testCases_Parse_IsDone_Invalid, testCases_Parse_CreatedOn_Invalid, testCases_Parse_UpdatedOn_Invalid] {
//            for testCase in testCases {
//                let task = TodoItem.parse(json: testCase)
//
//                XCTAssertNil(task)
//            }
//        }
//    }
//
//    func testParse_TodoItem_IsNotNil() {
//        for testCases in [testCases_Parse_Id_Valid, testCases_Parse_Text_Valid, testCases_Parse_Deadline_Valid, testCases_Parse_Priority_Valid, testCases_Parse_IsDone_Valid, testCases_Parse_CreatedOn_Valid, testCases_Parse_UpdatedOn_Valid] {
//            for testCase in testCases {
//                let task = TodoItem.parse(json: testCase)
//
//                let json = testCase as? [String: Any]
//
//                XCTAssertNotNil(task)
//                XCTAssertNotNil(json)
//                XCTAssertEqual(task!.id, json!["id"] as? String)
//                XCTAssertEqual(task!.text, json!["text"] as? String)
//
//                if json!["priority"] == nil {
//                    XCTAssertEqual(task!.priority, Priority.medium)
//                } else {
//                    XCTAssertEqual(task!.priority, Priority.init(rawValue: (json!["priority"] as? String ?? "")))
//                }
//
//                XCTAssertEqual(task!.isDone, json!["isDone"] as? Bool)
//
//                if json!["deadline"] == nil {
//                    XCTAssertNil(task!.deadline)
//                } else {
//                    XCTAssertEqual(task!.deadline, Date(timeIntervalSince1970: TimeInterval((json!["deadline"] as? Int ?? 0))))
//                }
//
//                XCTAssertEqual(task!.createdOn, Date(timeIntervalSince1970: TimeInterval((json!["createdOn"] as? Int ?? 0))))
//
//                if json!["updatedOn"] == nil {
//                    XCTAssertNil(task!.updatedOn)
//                } else {
//                    XCTAssertEqual(task!.updatedOn, Date(timeIntervalSince1970: TimeInterval((json!["updatedOn"] as? Int ?? 0))))
//                }
//            }
//        }
//    }
//
//
//    // MARK: Tests csv -> String
//    func test_Csv_IdGenerated_DeadlineAndUpdatedOn_IsNil() {
//        for testCase in TestsData.testCases_DeadlineAndUpdatedOn_IsNil {
//            task = TodoItem(id: testCase.id, text: testCase.text, priority: testCase.priority,
//                            deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn,
//                            updatedOn: testCase.updatedOn)
//            let csvStr = testCase.csv
//            let taskCsv = task.csv
//
//            XCTAssertEqual(taskCsv, csvStr)
//        }
//    }
//
//    //    func testJson_IdPassed_DeadlineAndUpdatedOn_IsNil() {
//    //        for testCase in testCases_DeadlineAndUpdatedOn_IsNil {
//    //            let id = UUID().uuidString
//    //            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let updatedOn: Int? = nil
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertNil(json!["deadline"])
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdGenerated_UpdatedOn_IsNil() {
//    //        for testCase in testCases_UpdatedOn_IsNil {
//    //            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let updatedOn: Int? = nil
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, task.id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdPassed_UpdatedOn_IsNil() {
//    //        for testCase in testCases_UpdatedOn_IsNil {
//    //            let id = UUID().uuidString
//    //            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let updatedOn: Int? = nil
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int?, updatedOn)
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdGenerated_Deadline_IsNil() {
//    //        for testCase in testCases_Deadline_IsNil {
//    //            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, task.id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertNil(json!["deadline"])
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdPassed_Deadline_IsNil() {
//    //        for testCase in testCases_Deadline_IsNil {
//    //            let id = UUID().uuidString
//    //            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertNil(json!["deadline"])
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdGenerated_Filled() {
//    //        for testCase in testCases_Filled {
//    //            task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, task.id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int, Int(testCase.updatedOn!.timeIntervalSince1970))
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//    //
//    //    func testJson_IdPassed_Filled() {
//    //        for testCase in testCases_Filled {
//    //            let id = UUID().uuidString
//    //            task = TodoItem(id: id, text: testCase.text, priority: testCase.priority, deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
//    //
//    //            let json = task.json as? [String: Any]
//    //
//    //            XCTAssertNotNil(json)
//    //            XCTAssertEqual(json!["id"] as? String, id)
//    //            XCTAssertEqual(json!["text"] as? String, testCase.text)
//    //            XCTAssertEqual(json!["deadline"] as? Int, Int(testCase.deadline!.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["isDone"] as? Bool, testCase.isDone)
//    //            XCTAssertEqual(json!["createdOn"] as? Int, Int(testCase.createdOn.timeIntervalSince1970))
//    //            XCTAssertEqual(json!["updatedOn"] as? Int?, Int(testCase.updatedOn!.timeIntervalSince1970))
//    //
//    //            if testCase.priority == .medium {
//    //                XCTAssertNil(json!["priority"])
//    //            } else {
//    //                XCTAssertEqual(json!["priority"] as? String, "\(testCase.priority)")
//    //            }
//    //        }
//    //    }
//
//    // MARK: Tests csv -> String
//    func test_ParseCsv_IdGenerated_DeadlineAndUpdatedOn_IsNil() {
//        for testCase in TestsData.testCases_DeadlineAndUpdatedOn_IsNil {
//            task = TodoItem(id: testCase.id, text: testCase.text, priority: testCase.priority,
//                            deadline: testCase.deadline, isDone: testCase.isDone, createdOn: testCase.createdOn,
//                            updatedOn: testCase.updatedOn)
//
//            let taskFromCsv = TodoItem.parse(csv: testCase.csv)
//            XCTAssertNotNil(taskFromCsv)
//            XCTAssertEqual(taskFromCsv!.id, task.id)
//            XCTAssertEqual(taskFromCsv!.text, task.text)
//            XCTAssertEqual(taskFromCsv!.priority, task.priority)
//            XCTAssertEqual(taskFromCsv!.deadline, task.deadline)
//            XCTAssertEqual(taskFromCsv!.isDone, task.isDone)
//            XCTAssertEqual(taskFromCsv!.createdOn, task.createdOn)
//            XCTAssertEqual(taskFromCsv!.updatedOn, task.updatedOn)
//        }
//    }
}
