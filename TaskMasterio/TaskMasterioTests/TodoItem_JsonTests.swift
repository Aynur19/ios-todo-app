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
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn] as? Int)

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
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
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertNil(json![TodoItem.Keys.deadline])
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_UpdatedOn_IsNil() throws  {
        for data in TestsData.testCases_UpdatedOn_IsNil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]

            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
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
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_Deadline_IsNil() throws  {
        for data in TestsData.testCases_Deadline_IsNil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
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
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdGenerated_Filled() throws  {
        for data in TestsData.testCases_Filled {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline, isDone: data.isDone,
                            createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
            }
        }
    }

    func test_Json_IdPassed_Filled() throws  {
        for data in TestsData.testCases_Filled {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.text, priority: data.priority, deadline: data.deadline,
                            isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)

            let json = task.json as? [String: Any]
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, data.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(data.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, data.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(data.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(data.updatedOn!.timeIntervalSince1970))

            if data.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, data.priority.rawValue)
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

