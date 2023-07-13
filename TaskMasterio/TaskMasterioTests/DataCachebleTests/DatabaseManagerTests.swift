//
//  DatabaseManagerTests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import XCTest
@testable import TaskMasterio

final class DatabaseManagerTests: XCTestCase {
    var database: DatabaseManager!

    override func setUpWithError() throws {
        database = DatabaseManager.shared
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        database = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests configurate()
    func tests_CreateDatabase_IsNew() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: СОЗДАНИЕ БАЗЫ ДАННЫХ И ТАБЛИЦ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_CreateDatabase", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        print("************************************************************************\n")
    }
    
    func tests_CreateDatabase_IsStored() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: СОЗДАНИЕ БАЗЫ ДАННЫХ И ТАБЛИЦ ЕДИНОЖДЫ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList", withDatetime: false, isTemp: false)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        print("************************************************************************\n")
    }
    
    // MARK: - Tests insert()
    func tests_Insert_IdIsNotFound() throws {
        let dateFormatter = DateFormatter()
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ЗАПИСЕЙ С НОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_CreateDatabase", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        var count = 0
        XCTAssertEqual(database.context.items.count, count)

        for data in TestsData.forInit {
            let item = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

            XCTAssertNil(database.insert(item))
            XCTAssertEqual(database.context.items[count].id, item.id)
            XCTAssertEqual(database.context.items[count].text, item.text)
            XCTAssertEqual(database.context.items[count].priority, item.priority)
            XCTAssertEqual(database.context.items[count].deadline, item.deadline)
            XCTAssertEqual(database.context.items[count].isDone, item.isDone)
            XCTAssertEqual(database.context.items[count].createdOn, item.createdOn)
            XCTAssertEqual(database.context.items[count].updatedOn, item.updatedOn)

            count += 1
            XCTAssertEqual(database.context.items.count, count)
        }
        
        database.save()
        print("************************************************************************\n")
    }

    func tests_Insert_IdFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ЗАПИСЕЙ С ОДИНАКОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_Insert_IdFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        let item = TodoItem(text: "test", priority: .low, deadline: nil, isDone: false, createdOn: Date(), updatedOn: nil)
        XCTAssertNil(database.insert(item))
        XCTAssertEqual(database.context.items.count, 1)

        let data = TestsData.forInit[0]
        let item2 = TodoItem(id: TestsData.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                  isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

        XCTAssertNil(database.insert(item2))
        XCTAssertEqual(database.context.items.count, 2)

        for testCase in TestsData.forInit {
            let item3 = TodoItem(id: TestsData.id, text: testCase.item.text, priority: testCase.item.priority,
                                  deadline: testCase.item.deadline, isDone: testCase.item.isDone,
                                  createdOn: testCase.item.createdOn, updatedOn: testCase.item.updatedOn)

            XCTAssertNotNil(database.insert(item3))

            XCTAssertEqual(database.context.items[0].id, item.id)
            XCTAssertEqual(database.context.items[0].text, item.text)
            XCTAssertEqual(database.context.items[0].priority, item.priority)
            XCTAssertEqual(database.context.items[0].deadline, item.deadline)
            XCTAssertEqual(database.context.items[0].isDone, item.isDone)
            XCTAssertEqual(database.context.items[0].createdOn, item.createdOn)
            XCTAssertEqual(database.context.items[0].updatedOn, item.updatedOn)

            XCTAssertEqual(database.context.items[1].id, item2.id)
            XCTAssertEqual(database.context.items[1].text, item2.text)
            XCTAssertEqual(database.context.items[1].priority, item2.priority)
            XCTAssertEqual(database.context.items[1].deadline, item2.deadline)
            XCTAssertEqual(database.context.items[1].isDone, item2.isDone)
            XCTAssertEqual(database.context.items[1].createdOn, item2.createdOn)
            XCTAssertEqual(database.context.items[1].updatedOn, item2.updatedOn)

            XCTAssertEqual(database.context.items.count, 2)
        }
        
        database.save()
        print("************************************************************************\n")
    }

    // MARK: - Tests update()
    func tests_Update_IdNotFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ОБНОВЛЕНИЕ ЗАПИСЕЙ С НОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_Update_IdNotFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        var count = 0
        XCTAssertEqual(database.context.items.count, count)

        for data in TestsData.forInit {
            let item = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

            XCTAssertNil(database.update(item))
            XCTAssertEqual(database.context.items.count, count)
        }
        
        _ = database.save()
        print("************************************************************************\n")
    }

    func tests_Update_IdIsFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ОБНОВЛЕНИЕ ЗАПИСЕЙ С ОДИНАКОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_Update_IdFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        let data = TestsData.forInit[0]
        let item = TodoItem(id: TestsData.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                  isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
        XCTAssertNil(database.insert(item))

        for testCase in TestsData.forInit {
            let item2 = TodoItem(id: TestsData.id, text: testCase.item.text, priority: testCase.item.priority,
                                  deadline: testCase.item.deadline, isDone: testCase.item.isDone,
                                  createdOn: testCase.item.createdOn, updatedOn: testCase.item.updatedOn)

            XCTAssertNotNil(database.update(item2))

            XCTAssertEqual(database.context.items[0].id, item2.id)
            XCTAssertEqual(database.context.items[0].text, item2.text)
            XCTAssertEqual(database.context.items[0].priority, item2.priority)
            XCTAssertEqual(database.context.items[0].deadline, item2.deadline)
            XCTAssertEqual(database.context.items[0].isDone, item2.isDone)
            XCTAssertEqual(database.context.items[0].createdOn, item2.createdOn)
            XCTAssertEqual(database.context.items[0].updatedOn, item2.updatedOn)

            XCTAssertEqual(database.context.items.count, 1)
        }
        
        _ = database.save()
        
        print("************************************************************************\n")
    }

    // MARK: - Tests insertOrUpdate()
    func tests_InsertOrUpdate_IdIsNotFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ИЛИ ОБНОВЛЕНИЕ ЗАПИСЕЙ С НОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_InsertOrUpdate_IdNotFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        var count = 0
        XCTAssertEqual(database.context.items.count, count)

        for data in TestsData.forInit {
            let item = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

            XCTAssertNil(database.insertOrUpdate(item))
            count += 1
            XCTAssertEqual(database.context.items.count, count)
        }
        
        _ = database.save()
        print("************************************************************************\n")
    }

    func tests_InsertOrUpdate_IdIsFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ИЛИ ОБНОВЛЕНИЕ ЗАПИСЕЙ С ОДИНАКОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_InsertOrUpdate_IdFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        let data = TestsData.forInit[0]
        let item = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                  isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
        XCTAssertNil(database.insert(item))

        let item2 = TodoItem(id: TestsData.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                             isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
        XCTAssertNil(database.insertOrUpdate(item2))

        for testCase in TestsData.forInit {
            let item3 = TodoItem(id: TestsData.id, text: testCase.item.text, priority: testCase.item.priority,
                                 deadline: testCase.item.deadline, isDone: testCase.item.isDone,
                                 createdOn: testCase.item.createdOn, updatedOn: testCase.item.updatedOn)

            XCTAssertNotNil(database.insertOrUpdate(item3))

            XCTAssertEqual(database.context.items[0].id, item.id)
            XCTAssertEqual(database.context.items[0].text, item.text)
            XCTAssertEqual(database.context.items[0].priority, item.priority)
            XCTAssertEqual(database.context.items[0].deadline, item.deadline)
            XCTAssertEqual(database.context.items[0].isDone, item.isDone)
            XCTAssertEqual(database.context.items[0].createdOn, item.createdOn)
            XCTAssertEqual(database.context.items[0].updatedOn, item.updatedOn)

            XCTAssertEqual(database.context.items[1].id, item3.id)
            XCTAssertEqual(database.context.items[1].text, item3.text)
            XCTAssertEqual(database.context.items[1].priority, item3.priority)
            XCTAssertEqual(database.context.items[1].deadline, item3.deadline)
            XCTAssertEqual(database.context.items[1].isDone, item3.isDone)
            XCTAssertEqual(database.context.items[1].createdOn, item3.createdOn)
            XCTAssertEqual(database.context.items[1].updatedOn, item3.updatedOn)

            XCTAssertEqual(database.context.items.count, 2)
        }
        
        _ = database.save()
        print("************************************************************************\n")
    }

    // MARK: - Tests delete()
    func tests_Delete_IdIsNotFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: УДАЛЕНИЕ ЗАПИСЕЙ КОГДА ИНДЕТИФИКАТОРЫ НЕ СОВПАДАЮТ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_Delete_IdNotFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        var count = 0
        XCTAssertEqual(database.context.items.count, count)

        for data in TestsData.forInit {
            let item = TodoItem(text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

            XCTAssertNil(database.insert(item))
            count += 1
            XCTAssertEqual(database.context.items.count, count)
        }

        for data in TestsData.forInit {
            let itemId = data.item.id

            XCTAssertNil(database.delete(by: itemId))
            XCTAssertEqual(database.context.items.count, count)
        }
        
        _ = database.save()
        print("************************************************************************\n")
    }

    func tests_Delete_IdIsFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: УДАЛЕНИЕ ЗАПИСЕЙ КОГДА ИНДЕТИФИКАТОРЫ СОВПАДАЮТ")
        
        let filepath = TestsData.getFilepath(prefix: "TodoList_Delete_IdFound", withDatetime: true)
        database.configure(name: filepath.filename, connectionUrl: filepath.url)
        database.traceQueries(isOn: true)
        
        var count = 0
        XCTAssertEqual(database.context.items.count, count)

        for data in TestsData.forInit {
            let item = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)

            XCTAssertNil(database.insert(item))
            count += 1
            XCTAssertEqual(database.context.items.count, count)
        }

        for data in TestsData.forInit {
            let itemId = data.item.id

            XCTAssertNotNil(database.delete(by: itemId))
            count -= 1
            XCTAssertEqual(database.context.items.count, count)
        }
        
        _ = database.save()
        print("************************************************************************\n")
    }
    
    // MARK: - Tests load()
    func tests_Load() throws {
        var items = [TodoItem]()
        for data in TestsData.forInit {
            let item = TodoItem(id: data.item.id, text: data.item.text, priority: data.item.priority, deadline: data.item.deadline,
                                isDone: data.item.isDone, createdOn: data.item.createdOn, updatedOn: data.item.updatedOn)
            items.append(item)
        }

        let jsonUrl = URL(fileURLWithPath: #file).deletingLastPathComponent()
            .appending(component: "TestFiles")

        XCTAssertTrue(FileManager.default.fileExists(atPath: jsonUrl.path))

        database.configure(name: "TaskMasterio_ForLoading", connectionUrl: jsonUrl)
        let result = database.load()

        XCTAssertEqual(database.context.items.count, items.count)

        for item in items {
            let itemFromDataCache = database.get(by: item.id)

            XCTAssertNotNil(itemFromDataCache)
            XCTAssertEqual(item.id, itemFromDataCache!.id)
            XCTAssertEqual(item.text, itemFromDataCache!.text)
            XCTAssertEqual(item.priority, itemFromDataCache!.priority)
            XCTAssertEqual(item.deadline, itemFromDataCache!.deadline)
            XCTAssertEqual(item.isDone, itemFromDataCache!.isDone)
            XCTAssertEqual(item.createdOn, itemFromDataCache!.createdOn)
            XCTAssertEqual(item.updatedOn, itemFromDataCache!.updatedOn)
        }
    }
}
