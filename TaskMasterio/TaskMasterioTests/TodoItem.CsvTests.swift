//
//  TodoItem.CsvTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 17.06.2023.
//

import XCTest
@testable import TaskMasterio

final class TodoItemCsvTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests csv -> String
    func test_Csv_DeadlineAndUpdatedOn_IsNil() throws {
        for data in TestsData.deadlineAndUpdatedOnIsNil {
            let task = data
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_UpdatedOn_IsNil() throws {
        for data in TestsData.updatedOnIsNil {
            let task = data
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_Deadline_IsNil() throws {
        for data in TestsData.deadlineIsNil {
            let task = data
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    func test_Csv_Filled() throws {
        for data in TestsData.filled {
            let task = data
            let csv = task.csv
            XCTAssertEqual(csv, data.csv)
        }
    }
    
    // MARK: - Tests parse(csv:) -> TodoItem?
    func test_Parse_Id_Invalid() {
        for data in CsvParseTestsData.idInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Text_Invalid() {
        for data in CsvParseTestsData.textInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Priotiry_Invalid() {
        for data in CsvParseTestsData.priorityInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Deadline_Invalid() {
        for data in CsvParseTestsData.deadlineInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_IsDone_Invalid() {
        for data in CsvParseTestsData.isDoneInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Invalid() {
        for data in CsvParseTestsData.createdOnInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Invalid() {
        for data in CsvParseTestsData.updatedOnInvalid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNil(task)
        }
    }
    
    func test_Parse_Id_Valid() {
        for data in CsvParseTestsData.idValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Text_Valid() {
        for data in CsvParseTestsData.textValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Priotiry_Valid() {
        for data in CsvParseTestsData.priorityValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_Deadline_Valid() {
        for data in CsvParseTestsData.deadlineValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_IsDone_Valid() {
        for data in CsvParseTestsData.isDoneValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_CreatedOn_Valid() {
        for data in CsvParseTestsData.createdOnValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
    
    func test_Parse_UpdatedOn_Valid() {
        for data in CsvParseTestsData.updatedOnValid[1...] {
            let task = TodoItem.parse(csv: data)
            
            XCTAssertNotNil(task)
        }
    }
}
