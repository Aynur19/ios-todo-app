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
}
