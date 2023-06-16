//
//  TodoItem_JsonTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItem_JsonTests: XCTestCase {
//    var task: TodoItem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
//        task = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests json -> Any
    func test_Json_IdGenerated_DeadlineAndUpdatedOn_IsNil() {
        for data in TestsData.testCases_DeadlineAndUpdatedOn_IsNil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, task.id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertNil(json![TodoItemKeys.deadline.rawValue] as? Int)
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItemKeys.updatedOn.rawValue] as? Int)

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdPassed_DeadlineAndUpdatedOn_IsNil() {
        for data in TestsData.testCases_DeadlineAndUpdatedOn_IsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertNil(json![TodoItemKeys.deadline.rawValue])
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItemKeys.updatedOn.rawValue])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_UpdatedOn_IsNil() {
        for data in TestsData.testCases_UpdatedOn_IsNil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]

            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, task.id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertEqual(json![TodoItemKeys.deadline.rawValue] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItemKeys.updatedOn.rawValue])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdPassed_UpdatedOn_IsNil() {
        for data in TestsData.testCases_UpdatedOn_IsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertEqual(json![TodoItemKeys.deadline.rawValue] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItemKeys.updatedOn.rawValue])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_Deadline_IsNil() {
        for data in TestsData.testCases_Deadline_IsNil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, task.id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertNil(json![TodoItemKeys.deadline.rawValue] as? Int)
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.updatedOn.rawValue] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdPassed_Deadline_IsNil() {
        for data in TestsData.testCases_Deadline_IsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertNil(json![TodoItemKeys.deadline.rawValue] as? Int)
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.updatedOn.rawValue] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_Filled() {
        for data in TestsData.testCases_Filled {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, task.id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertEqual(json![TodoItemKeys.deadline.rawValue] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.updatedOn.rawValue] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }

    func testJson_IdPassed_Filled() {
        for data in TestsData.testCases_Filled {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItemKeys.id.rawValue] as? String, id)
            XCTAssertEqual(json![TodoItemKeys.text.rawValue] as? String, data.text)
            XCTAssertEqual(json![TodoItemKeys.deadline.rawValue] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.isDone.rawValue] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItemKeys.createdOn.rawValue] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItemKeys.updatedOn.rawValue] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItemKeys.priority.rawValue])
            } else {
                XCTAssertEqual(json![TodoItemKeys.priority.rawValue] as? String, data.priority.rawValue)
            }
        }
    }


//    // MARK: - Tests parse(json:) -> TodoItem?
//    func test_Parse_TodoItem_IsNil() {
//        for data in TestsData.testCases_Json_Invalid {
//            let task = TodoItem.parse(json: data)
//
//            XCTAssertNil(task)
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




