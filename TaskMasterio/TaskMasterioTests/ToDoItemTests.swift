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
}

extension ToDoItemTests {
    func testInit(idx: UUID?, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?) throws {
        
        if idx != nil {
            task = TodoItem(id: idx!.uuidString, text: text, priority: priority, deadline: deadline, isDone: isDone, createdOn: createdOn, updatedOn: updatedOn)
        } else {
            task = TodoItem(text: text, priority: priority, deadline: deadline, isDone: isDone, createdOn: createdOn, updatedOn: updatedOn)
        }
        
        XCTAssertNotNil(task)
        
        if idx != nil {
            XCTAssertEqual(task.id, idx!.uuidString)
        } else {
            XCTAssertNotNil(task.id)
        }
        
        XCTAssertEqual(task.text, text)
        XCTAssertEqual(task.priority, priority)
        XCTAssertEqual(task.deadline, deadline)
        XCTAssertEqual(task.isDone, isDone)
        XCTAssertEqual(task.createdOn, createdOn)
        XCTAssertEqual(task.updatedOn, updatedOn)
    }
    
    func testInitWithParameters() throws {
        // all optionals == nil; id - generated; 3 options for priority
        try testInit(idx: nil, text: "text", priority: .high, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: isDone = true
        try testInit(idx: nil, text: "text", priority: .high, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: passing generated id
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: deadline != nil
        let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        
        // added variation: updatedOn != nil
        let next5min = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: nil, text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "text", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "text", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
    }
}
