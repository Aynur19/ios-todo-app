//
//  TodoItemTests.JsonSerialization.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItemJsonSerializationTests: XCTestCase {
    
    // MARK: - Tests json -> Any
    func test_Json_IdGenerated_DeadlineAndUpdatedOn_IsNil() throws {
        for data in TestsData.deadlineAndUpdatedOnIsNil {
            let task = data.item
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn] as? Int)
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdPassed_DeadlineAndUpdatedOn_IsNil() throws {
        for data in TestsData.deadlineAndUpdatedOnIsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertNil(json![TodoItem.Keys.deadline])
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdGenerated_UpdatedOn_IsNil() throws {
        for data in TestsData.updatedOnIsNil {
            let task = data.item
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(task.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdPassed_UpdatedOn_IsNil() throws {
        for data in TestsData.updatedOnIsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(task.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertNil(json![TodoItem.Keys.updatedOn])
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdGenerated_Deadline_IsNil() throws {
        for data in TestsData.deadlineIsNil {
            let task = data.item
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(task.updatedOn!.timeIntervalSince1970))
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdPassed_Deadline_IsNil() throws {
        for data in TestsData.deadlineIsNil {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertNil(json![TodoItem.Keys.deadline] as? Int)
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(task.updatedOn!.timeIntervalSince1970))
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdGenerated_Filled() throws {
        for data in TestsData.filled {
            let task = data.item
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, task.id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(task.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(task.updatedOn!.timeIntervalSince1970))
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    func test_Json_IdPassed_Filled() throws {
        for data in TestsData.filled {
            let id = TestsData.id
            let task = TodoItem(id: id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            let json = task.json as? [String: Any]
            
            XCTAssertNotNil(json)
            XCTAssertEqual(json![TodoItem.Keys.id] as? String, id)
            XCTAssertEqual(json![TodoItem.Keys.text] as? String, task.text)
            XCTAssertEqual(json![TodoItem.Keys.deadline] as? Int, Int(task.deadline!.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.isDone] as? Bool, task.isDone)
            XCTAssertEqual(json![TodoItem.Keys.createdOn] as? Int, Int(task.createdOn.timeIntervalSince1970))
            XCTAssertEqual(json![TodoItem.Keys.updatedOn] as? Int, Int(task.updatedOn!.timeIntervalSince1970))
            
            if task.priority == .medium {
                XCTAssertNil(json![TodoItem.Keys.priority])
            } else {
                XCTAssertEqual(json![TodoItem.Keys.priority] as? String, task.priority.rawValue)
            }
        }
    }
    
    // MARK: - Tests parse(json:) -> TodoItem?
    func test_Parse_Id_Invalid() throws {
        for data in JsonParseTestsData.idInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Text_Invalid() throws {
        for data in JsonParseTestsData.textInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Priotiry_Invalid() throws {
        for data in JsonParseTestsData.priorityInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Deadline_Invalid() throws {
        for data in JsonParseTestsData.deadlineInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_IsDone_Invalid() throws {
        for data in JsonParseTestsData.isDoneInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Invalid() throws {
        for data in JsonParseTestsData.createdOnInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Invalid() throws {
        for data in JsonParseTestsData.updatedOnInvalid {
            let task = TodoItem.parse(json: data)
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Id_Valid() throws {
        for data in JsonParseTestsData.idValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Text_Valid() throws {
        for data in JsonParseTestsData.textValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Priotiry_Valid() throws {
        for data in JsonParseTestsData.priorityValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Deadline_Valid() throws {
        for data in JsonParseTestsData.deadlineValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_IsDone_Valid() throws {
        for data in JsonParseTestsData.isDoneValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Valid() throws {
        for data in JsonParseTestsData.createdOnValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Valid() throws {
        for data in JsonParseTestsData.updatedOnValid {
            let task = TodoItem.parse(json: data)
            XCTAssertNotNil(task)
        }
    }
}
