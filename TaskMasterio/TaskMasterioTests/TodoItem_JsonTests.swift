//
//  TodoItem_JsonTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItem_JsonTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests json -> Any
    func test_Json_IdGenerated_DeadlineAndUpdatedOn_IsNil() throws  {
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

    func test_Json_IdPassed_DeadlineAndUpdatedOn_IsNil() throws  {
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

    func test_Json_IdGenerated_UpdatedOn_IsNil() throws  {
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

    func test_Json_IdPassed_UpdatedOn_IsNil() throws  {
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

    func test_Json_IdGenerated_Deadline_IsNil() throws  {
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

    func test_Json_IdPassed_Deadline_IsNil() throws  {
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

    func test_Json_IdGenerated_Filled() throws  {
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

    func testJson_IdPassed_Filled() throws  {
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


    // MARK: - Tests parse(json:) -> TodoItem?
    func test_Parse_Id_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_Id_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Text_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_Text_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Priotiry_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_Priority_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Deadline_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_Deadline_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_IsDone_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_IsDone_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_CreatedOn_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Invalid() throws  {
        for data in TestsData.testCases_ParseJson_UpdatedOn_Invalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Id_Valid() throws  {
        for data in TestsData.testCases_ParseJson_Id_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Text_Valid() throws  {
        for data in TestsData.testCases_ParseJson_Text_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Priotiry_Valid() throws  {
        for data in TestsData.testCases_ParseJson_Priority_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Deadline_Valid() throws  {
        for data in TestsData.testCases_ParseJson_Deadline_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_IsDone_Valid() throws  {
        for data in TestsData.testCases_ParseJson_IsDone_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Valid() throws {
        for data in TestsData.testCases_ParseJson_CreatedOn_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Valid() throws  {
        for data in TestsData.testCases_ParseJson_UpdatedOn_Valid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
}

