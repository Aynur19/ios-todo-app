//
//  TodoItemTests.Init.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItemTestsInit: XCTestCase {
    // MARK: - Tests init()
    func test_Init_IdGenerated() throws {
        for data in TestsData.forInit {
            let task = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                            isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            
            XCTAssertNotNil(task)
            XCTAssertNotNil(task.id)
            XCTAssertEqual(task.text, data.item.text)
            XCTAssertEqual(task.priority, data.item.priority)
            XCTAssertEqual(task.deadline, data.item.deadline)
            XCTAssertEqual(task.isDone, data.item.isDone)
            XCTAssertEqual(task.createdOn, data.item.createdOn)
            XCTAssertEqual(task.updatedOn, data.item.updatedOn)
        }
    }
    
    func test_Init_IdPassed() throws {
        
        for data in TestsData.forInit {
            let task = TodoItem(id: TestsData.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                            isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
        
            XCTAssertNotNil(task)
            XCTAssertEqual(task.id, TestsData.id)
            XCTAssertEqual(task.text, data.item.text)
            XCTAssertEqual(task.priority, data.item.priority)
            XCTAssertEqual(task.deadline, data.item.deadline)
            XCTAssertEqual(task.isDone, data.item.isDone)
            XCTAssertEqual(task.createdOn, data.item.createdOn)
            XCTAssertEqual(task.updatedOn, data.item.updatedOn)
        }
    }
}
