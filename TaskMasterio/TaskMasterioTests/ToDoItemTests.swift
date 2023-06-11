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
        try testInit(idx: nil, text: "test 1", priority: .high, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 2", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 3", priority: .medium, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: isDone = true
        try testInit(idx: nil, text: "test 4", priority: .high, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 5", priority: .low, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 6", priority: .medium, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: passing generated id
        try testInit(idx: UUID(), text: "test 7", priority: .high, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 8", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 9", priority: .medium, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "test 10", priority: .high, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 11", priority: .low, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 12", priority: .medium, deadline: nil, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: deadline != nil
        let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        try testInit(idx: nil, text: "test 13", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 14", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 15", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: nil, text: "test 16", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 17", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: nil, text: "test 18", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "test 19", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 20", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 21", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: nil)
        
        try testInit(idx: UUID(), text: "test 22", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 23", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        try testInit(idx: UUID(), text: "test 24", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: nil)
        
        
        // added variation: updatedOn != nil
        let next5min = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
        try testInit(idx: nil, text: "test 25", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 26", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 27", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: nil, text: "test 28", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 29", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 30", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "test 31", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 32", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 33", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "test 34", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 35", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 36", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        
        try testInit(idx: nil, text: "test 37", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 38", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 39", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: nil, text: "test 40", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 41", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: nil, text: "test 42", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "test 43", priority: .high, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 44", priority: .low, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 45", priority: .medium, deadline: nextWeek, isDone: false, createdOn: Date(), updatedOn: next5min)
        
        try testInit(idx: UUID(), text: "test 46", priority: .high, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 47", priority: .low, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
        try testInit(idx: UUID(), text: "test 48", priority: .medium, deadline: nextWeek, isDone: true, createdOn: Date(), updatedOn: next5min)
    }
    
    func testToJson() {
        let json = "{\n\t\"id\": \"A5A600C6-9B8F-4B36-AD55-F49B3D55C975\",\n\t\"text\": \"test 1\",\n\t\"priority\": \"low\",\n\t\"deadline\": \"1686600000.555\",\n\t\"isDone\": \"false\",\n\t\"createdOn\": \"1686550000.555\",\n\t\"updatedOn\": \"1686555000.555\"\n}"
        
        let task = TodoItem(id: "A5A600C6-9B8F-4B36-AD55-F49B3D55C975", text: "test 1", priority: .low, deadline: Date(timeIntervalSince1970: 1686600000.555), isDone: false, createdOn: Date(timeIntervalSince1970: 1686550000.555), updatedOn: Date(timeIntervalSince1970: 1686555000.555))
        
        XCTAssertNotNil(task)

        XCTAssertNoThrow(task.json)
        XCTAssertNotNil(task.json)

        XCTAssertNoThrow(task.json as? String)
        XCTAssertNotNil(task.json as? String)
        
        XCTAssertEqual(task.json as! String, json)
    }
}
