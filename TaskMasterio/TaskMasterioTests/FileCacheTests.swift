//
//  FileCacheTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import XCTest
@testable import TaskMasterio


final class FileCacheTests: XCTestCase {
    var fileCache: FileCache!
    
    override func setUpWithError() throws {
        fileCache = FileCache()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        fileCache = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests add()
    func test_AddElement_IdIsNew() throws {
        var count = 0
        XCTAssertEqual(fileCache.tasks.count, count)
        for testCase in TestsData.testCases_Id_Nil {
            let task = TodoItem(text: testCase.text, priority: testCase.priority, deadline: testCase.deadline,
                                isDone: testCase.isDone, createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            XCTAssertTrue(fileCache.add(task))
            XCTAssertEqual(fileCache.tasks[count].id, task.id)
            XCTAssertEqual(fileCache.tasks[count].text, task.text)
            XCTAssertEqual(fileCache.tasks[count].priority, task.priority)
            XCTAssertEqual(fileCache.tasks[count].deadline, task.deadline)
            XCTAssertEqual(fileCache.tasks[count].isDone, task.isDone)
            XCTAssertEqual(fileCache.tasks[count].createdOn, task.createdOn)
            XCTAssertEqual(fileCache.tasks[count].updatedOn, task.updatedOn)
            
            count += 1
            XCTAssertEqual(fileCache.tasks.count, count)
        }
    }
    
    func test_AddElement_IdIsSame() throws {
        let task = TodoItem(text: "test", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        XCTAssertTrue(fileCache.add(task))
        XCTAssertEqual(fileCache.tasks.count, 1)
        
        let data = TestsData.testCases_Id_Nil[0]
        var taskSameId = TodoItem(id: TestsData.id, text: data.text, priority: data.priority, deadline: data.deadline,
                                  isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
        
        XCTAssertTrue(fileCache.add(taskSameId))
        XCTAssertEqual(fileCache.tasks.count, 2)
        
        for testCase in TestsData.testCases_Id_Nil {
            taskSameId = TodoItem(id: TestsData.id, text: testCase.text, priority: testCase.priority,
                                deadline: testCase.deadline, isDone: testCase.isDone,
                                createdOn: testCase.createdOn, updatedOn: testCase.updatedOn)
            
            XCTAssertFalse(fileCache.add(taskSameId))
            
            XCTAssertEqual(fileCache.tasks[0].id, task.id)
            XCTAssertEqual(fileCache.tasks[0].text, task.text)
            XCTAssertEqual(fileCache.tasks[0].priority, task.priority)
            XCTAssertEqual(fileCache.tasks[0].deadline, task.deadline)
            XCTAssertEqual(fileCache.tasks[0].isDone, task.isDone)
            XCTAssertEqual(fileCache.tasks[0].createdOn, task.createdOn)
            XCTAssertEqual(fileCache.tasks[0].updatedOn, task.updatedOn)
            
            XCTAssertEqual(fileCache.tasks[1].id, taskSameId.id)
            XCTAssertEqual(fileCache.tasks[1].text, taskSameId.text)
            XCTAssertEqual(fileCache.tasks[1].priority, taskSameId.priority)
            XCTAssertEqual(fileCache.tasks[1].deadline, taskSameId.deadline)
            XCTAssertEqual(fileCache.tasks[1].isDone, taskSameId.isDone)
            XCTAssertEqual(fileCache.tasks[1].createdOn, taskSameId.createdOn)
            XCTAssertEqual(fileCache.tasks[1].updatedOn, taskSameId.updatedOn)
            
            XCTAssertEqual(fileCache.tasks.count, 2)
        }
    }
    
    
    // MARK: - Tests saveToJson()
    func test_SaveToJson() throws {
        var tasks = [TodoItem]()
        for data in TestsData.testCases_Id_Nil {
            let task = TodoItem(text: data.text, priority: data.priority, deadline: data.deadline,
                                isDone: data.isDone, createdOn: data.createdOn, updatedOn: data.updatedOn)
            _ = fileCache.add(task)
            _ = tasks.append(task)
        }
        
        let projectURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
                                                    .appending(component: "TestFiles")
                                                    .appending(path: "TaskMasterio.json")
        
        XCTAssertTrue(fileCache.saveToJson(name: "TaskMasterio", to: projectURL))
        XCTAssertTrue(FileManager.default.fileExists(atPath: projectURL.path))
        
        fileCache.clear()
        
        let jsonData = try? Data(contentsOf: projectURL)
        XCTAssertNotNil(jsonData)
              
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData!) as? [Any]
        XCTAssertNotNil(jsonObject)
        
        let tasksDict = jsonObject as? [[String: Any]]
        XCTAssertNotNil(tasksDict)
        
        for task in tasksDict! {
            let taskFromJson = TodoItem.parse(json: task)
            XCTAssertNotNil(taskFromJson)
            XCTAssertTrue(fileCache.add(taskFromJson!))
            
        }
        
        XCTAssertEqual(fileCache.tasks.count, tasks.count)

    }
}
