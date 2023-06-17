//
//  TodoItem_CsvTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 17.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItem_CsvTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests csv -> String
    func test_Csv_DeadlineAndUpdatedOn_IsNil() throws  {
        for data in TestsData.testCases_DeadlineAndUpdatedOn_IsNil {
            let task = TodoItem(id: data.id, text: data.text, priority: data.priority, deadline: data.deadline,
                                isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_UpdatedOn_IsNil() throws  {
        for data in TestsData.testCases_UpdatedOn_IsNil {
            let task = TodoItem(id: data.id, text: data.text, priority: data.priority, deadline: data.deadline,
                                isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_Deadline_IsNil() throws  {
        for data in TestsData.testCases_Deadline_IsNil {
            let task = TodoItem(id: data.id, text: data.text, priority: data.priority, deadline: data.deadline,
                                isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_Filled() throws {
        for data in TestsData.testCases_Filled {
            let task = TodoItem(id: data.id, text: data.text, priority: data.priority, deadline: data.deadline,
                                isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    
    // MARK: - Tests parse(csv:) -> TodoItem?
    func test_Parse_Id_Invalid() {
        for data in TestsData.testCases_ParseCsv_Id_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Text_Invalid() {
        for data in TestsData.testCases_ParseCsv_Text_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Priotiry_Invalid() {
        for data in TestsData.testCases_ParseCsv_Priority_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Deadline_Invalid() {
        for data in TestsData.testCases_ParseCsv_Deadline_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_IsDone_Invalid() {
        for data in TestsData.testCases_ParseCsv_IsDone_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Invalid() {
        for data in TestsData.testCases_ParseCsv_CreatedOn_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Invalid() {
        for data in TestsData.testCases_ParseCsv_UpdatedOn_Invalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Id_Valid() {
        for data in TestsData.testCases_ParseCsv_Id_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Text_Valid() {
        for data in TestsData.testCases_ParseCsv_Text_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Priotiry_Valid() {
        for data in TestsData.testCases_ParseCsv_Priority_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Deadline_Valid() {
        for data in TestsData.testCases_ParseCsv_Deadline_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_IsDone_Valid() {
        for data in TestsData.testCases_ParseCsv_IsDone_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Valid() {
        for data in TestsData.testCases_ParseCsv_CreatedOn_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Valid() {
        for data in TestsData.testCases_ParseCsv_UpdatedOn_Valid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
}
