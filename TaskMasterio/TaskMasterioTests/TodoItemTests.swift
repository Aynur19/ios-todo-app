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
    
    
    // MARK: - Tests init()
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
