////
////  FileCacheTests.swift
////  TaskMasterioTests
////
////  Created by Aynur Nasybullin on 15.06.2023.
////
//
//import XCTest
//@testable import TaskMasterio
//
//final class FileCacheTests: XCTestCase {
//    var fileCache: FileCache!
//    
//    override func setUpWithError() throws {
//        fileCache = FileCache()
//        try super.setUpWithError()
//    }
//    
//    override func tearDownWithError() throws {
//        fileCache = nil
//        try super.tearDownWithError()
//    }
//    
//    // MARK: - Tests add()
//    func test_Add_IdIsNew() throws {
//        var count = 0
//        XCTAssertEqual(fileCache.tasks.count, count)
//        for data in TestsData.forInit {
//            let task = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            
//            XCTAssertNil(fileCache.add(task))
//            XCTAssertEqual(fileCache.tasks[count].id, task.id)
//            XCTAssertEqual(fileCache.tasks[count].text, task.text)
//            XCTAssertEqual(fileCache.tasks[count].priority, task.priority)
//            XCTAssertEqual(fileCache.tasks[count].deadline, task.deadline)
//            XCTAssertEqual(fileCache.tasks[count].isDone, task.isDone)
//            XCTAssertEqual(fileCache.tasks[count].createdOn, task.createdOn)
//            XCTAssertEqual(fileCache.tasks[count].updatedOn, task.updatedOn)
//            
//            count += 1
//            XCTAssertEqual(fileCache.tasks.count, count)
//        }
//    }
//    
//    func test_Add_IdIsSame() throws {
//        let task = TodoItem(text: "test", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
//        XCTAssertNil(fileCache.add(task))
//        XCTAssertEqual(fileCache.tasks.count, 1)
//        
//        let data = TestsData.forInit[0]
//        var taskSameId = TodoItem(id: TestsData.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                  isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//        
//        XCTAssertNil(fileCache.add(taskSameId))
//        XCTAssertEqual(fileCache.tasks.count, 2)
//        
//        for testCase in TestsData.forInit {
//            taskSameId = TodoItem(id: TestsData.id, text: testCase.item.text, priority: testCase.item.priority,
//                                  deadline: testCase.item.deadline, isDone: testCase.item.isDone,
//                                  createdOn: testCase.item.createdOn, updatedOn: testCase.item.updatedOn)
//            
//            XCTAssertNotNil(fileCache.add(taskSameId))
//            
//            XCTAssertEqual(fileCache.tasks[0].id, task.id)
//            XCTAssertEqual(fileCache.tasks[0].text, task.text)
//            XCTAssertEqual(fileCache.tasks[0].priority, task.priority)
//            XCTAssertEqual(fileCache.tasks[0].deadline, task.deadline)
//            XCTAssertEqual(fileCache.tasks[0].isDone, task.isDone)
//            XCTAssertEqual(fileCache.tasks[0].createdOn, task.createdOn)
//            XCTAssertEqual(fileCache.tasks[0].updatedOn, task.updatedOn)
//            
//            XCTAssertEqual(fileCache.tasks[1].id, taskSameId.id)
//            XCTAssertEqual(fileCache.tasks[1].text, taskSameId.text)
//            XCTAssertEqual(fileCache.tasks[1].priority, taskSameId.priority)
//            XCTAssertEqual(fileCache.tasks[1].deadline, taskSameId.deadline)
//            XCTAssertEqual(fileCache.tasks[1].isDone, taskSameId.isDone)
//            XCTAssertEqual(fileCache.tasks[1].createdOn, taskSameId.createdOn)
//            XCTAssertEqual(fileCache.tasks[1].updatedOn, taskSameId.updatedOn)
//            
//            XCTAssertEqual(fileCache.tasks.count, 2)
//        }
//    }
//    
//    // MARK: - Tests saveToJson()
//    func test_SaveToJson_Rewriting() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            _ = fileCache.add(task)
//            tasks.append(task)
//        }
//        
//        var testFilesDirUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()
//            .appending(component: "TestFiles")
//            .appending(component: "Generated")
//        
//        XCTAssertNoThrow(try fileCache.saveToJson(name: "TaskMasterio", to: testFilesDirUrl))
//        testFilesDirUrl.append(path: "TaskMasterio.json")
//        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilesDirUrl.path()))
//        
//        fileCache.clearTasks()
//        
//        let jsonData = try Data(contentsOf: testFilesDirUrl)
//        XCTAssertNotNil(jsonData)
//              
//        let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [Any]
//        XCTAssertNotNil(jsonObject)
//        
//        let tasksDict = jsonObject as? [[String: Any]]
//        XCTAssertNotNil(tasksDict)
//        
//        for taskDict in tasksDict! {
//            let taskFromJson = TodoItem.parse(json: taskDict)
//            XCTAssertNotNil(taskFromJson)
//            XCTAssertNil(fileCache.add(taskFromJson!))
//            
//            let taskFromList = tasks.first(where: { $0.id == taskFromJson!.id })
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(taskFromJson!.id, taskFromList!.id)
//            XCTAssertEqual(taskFromJson!.text, taskFromList!.text)
//            XCTAssertEqual(taskFromJson!.priority, taskFromList!.priority)
//            XCTAssertEqual(taskFromJson!.deadline, taskFromList!.deadline)
//            XCTAssertEqual(taskFromJson!.isDone, taskFromList!.isDone)
//            XCTAssertEqual(taskFromJson!.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(taskFromJson!.updatedOn, taskFromList!.updatedOn)
//        }
//        
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//    }
//    
//    func test_SaveToJson_NewFile() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            _ = fileCache.add(task)
//            tasks.append(task)
//        }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
//        let filename = "TaskMasterio_(\(dateFormatter.string(from: Date())))"
//        
//        var testFilesDirUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()
//                                                    .appending(component: "TestFiles")
//                                                    .appending(component: "Generated")
//        
//        XCTAssertNoThrow(try fileCache.saveToJson(name: filename, to: testFilesDirUrl))
//        testFilesDirUrl.append(path: "\(filename).json")
//        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilesDirUrl.path))
//        
//        fileCache.clearTasks()
//        
//        let jsonData = try Data(contentsOf: testFilesDirUrl)
//        XCTAssertNotNil(jsonData)
//              
//        let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [Any]
//        XCTAssertNotNil(jsonObject)
//        
//        let tasksDict = jsonObject as? [[String: Any]]
//        XCTAssertNotNil(tasksDict)
//        
//        for taskDict in tasksDict! {
//            let taskFromJson = TodoItem.parse(json: taskDict)
//            XCTAssertNotNil(taskFromJson)
//            XCTAssertNil(fileCache.add(taskFromJson!))
//            
//            let taskFromList = tasks.first(where: { $0.id == taskFromJson!.id })
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(taskFromJson!.id, taskFromList!.id)
//            XCTAssertEqual(taskFromJson!.text, taskFromList!.text)
//            XCTAssertEqual(taskFromJson!.priority, taskFromList!.priority)
//            XCTAssertEqual(taskFromJson!.deadline, taskFromList!.deadline)
//            XCTAssertEqual(taskFromJson!.isDone, taskFromList!.isDone)
//            XCTAssertEqual(taskFromJson!.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(taskFromJson!.updatedOn, taskFromList!.updatedOn)
//        }
//        
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//    }
//    
//    // MARK: - Tests loadFromJson()
//    func test_LoadFromJson() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            tasks.append(task)
//        }
//        
//        let projectURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
//                                                    .appending(component: "TestFiles")
//        
//        XCTAssertTrue(FileManager.default.fileExists(atPath: projectURL.path))
//        XCTAssertNoThrow(try fileCache.loadFromJson(name: "TaskMasterio_ForLoading", to: projectURL))
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//        
//        for task in fileCache.tasks {
//            let taskFromList = tasks.first(where: { $0.id == task.id })
//            
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(task.id, taskFromList!.id)
//            XCTAssertEqual(task.text, taskFromList!.text)
//            XCTAssertEqual(task.priority, taskFromList!.priority)
//            XCTAssertEqual(task.deadline, taskFromList!.deadline)
//            XCTAssertEqual(task.isDone, taskFromList!.isDone)
//            XCTAssertEqual(task.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(task.updatedOn, taskFromList!.updatedOn)
//        }
//
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//    }
//    
//    // MARK: - Tests saveToCsv()
//    func test_SaveToCsv_Rewriting() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            _ = fileCache.add(task)
//            tasks.append(task)
//        }
//        
//        var testFilesDirUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()
//                                                    .appending(component: "TestFiles")
//                                                    .appending(component: "Generated")
//        
//        XCTAssertNoThrow(try fileCache.saveToCsv(name: "TaskMasterio", to: testFilesDirUrl))
//        testFilesDirUrl.append(path: "TaskMasterio.csv")
//        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilesDirUrl.path))
//        
//        fileCache.clearTasks()
//        
//        let csv = try String(contentsOf: testFilesDirUrl, encoding: .utf8)
//        XCTAssertNotNil(csv)
//        
//        let rows = csv.split(separator: "\n").map({ String($0) })
//        XCTAssertNotNil(csv)
//        
//        XCTAssertEqual(rows[0], TodoItemCsvSerializator.getHeaders())
//        XCTAssertEqual(rows.count, tasks.count + 1)
//        
//        for row in rows[1...] {
//            let task = TodoItem.parse(csv: row)
//            let taskFromList = tasks.first(where: { $0.id == task!.id })
//
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(task!.id, taskFromList!.id)
//            XCTAssertEqual(task!.text, taskFromList!.text)
//            XCTAssertEqual(task!.priority, taskFromList!.priority)
//            XCTAssertEqual(task!.deadline, taskFromList!.deadline)
//            XCTAssertEqual(task!.isDone, taskFromList!.isDone)
//            XCTAssertEqual(task!.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(task!.updatedOn, taskFromList!.updatedOn)
//        }
//    }
//    
//    func test_SaveToCsv_NewFile() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            _ = fileCache.add(task)
//            tasks.append(task)
//        }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
//        let filename = "TaskMasterio_(\(dateFormatter.string(from: Date())))"
//        
//        var testFilesDirUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()
//                                                    .appending(component: "TestFiles")
//                                                    .appending(component: "Generated")
//        
//        XCTAssertNoThrow(try fileCache.saveToCsv(name: filename, to: testFilesDirUrl))
//        testFilesDirUrl.append(path: "\(filename).csv")
//        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilesDirUrl.path()))
//        
//        fileCache.clearTasks()
//        
//        let csv = try String(contentsOf: testFilesDirUrl, encoding: .utf8)
//        XCTAssertNotNil(csv)
//        
//        let rows = csv.split(separator: "\n").map({ String($0) })
//        XCTAssertNotNil(csv)
//        
//        XCTAssertEqual(rows[0], TodoItemCsvSerializator.getHeaders())
//        XCTAssertEqual(rows.count, tasks.count + 1)
//        
//        for row in rows[1...] {
//            let task = TodoItem.parse(csv: row)
//            let taskFromList = tasks.first(where: { $0.id == task!.id })
//
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(task!.id, taskFromList!.id)
//            XCTAssertEqual(task!.text, taskFromList!.text)
//            XCTAssertEqual(task!.priority, taskFromList!.priority)
//            XCTAssertEqual(task!.deadline, taskFromList!.deadline)
//            XCTAssertEqual(task!.isDone, taskFromList!.isDone)
//            XCTAssertEqual(task!.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(task!.updatedOn, taskFromList!.updatedOn)
//        }
//    }
//    
//    // MARK: - Tests loadFromCsv()
//    func test_LoadFromCsv() throws {
//        var tasks = [TodoItem]()
//        for data in TestsData.forInit {
//            let task = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
//                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
//            tasks.append(task)
//        }
//        
//        let projectURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
//                                                    .appending(component: "TestFiles")
//        
//        XCTAssertTrue(FileManager.default.fileExists(atPath: projectURL.path))
//        
//        XCTAssertNoThrow(try fileCache.loadFromCsv(name: "TaskMasterio_ForLoading", from: projectURL))
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//        
//        for task in fileCache.tasks {
//            let taskFromList = tasks.first(where: { $0.id == task.id })
//            
//            XCTAssertNotNil(taskFromList)
//            XCTAssertEqual(task.id, taskFromList!.id)
//            XCTAssertEqual(task.text, taskFromList!.text)
//            XCTAssertEqual(task.priority, taskFromList!.priority)
//            XCTAssertEqual(task.deadline, taskFromList!.deadline)
//            XCTAssertEqual(task.isDone, taskFromList!.isDone)
//            XCTAssertEqual(task.createdOn, taskFromList!.createdOn)
//            XCTAssertEqual(task.updatedOn, taskFromList!.updatedOn)
//        }
//
//        XCTAssertEqual(fileCache.tasks.count, tasks.count)
//    }
//}
