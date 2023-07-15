//
//  CoreData.TodoList.Tests.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 15.07.2023.
//

import XCTest
@testable import TaskMasterio

final class CoreDataTodoListDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataUnitOfWork!

    override func setUpWithError() throws {
        coreDataManager = CoreDataUnitOfWork.shared
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests configurate()
    func tests_CreateDatabase_IsNew() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: СОЗДАНИЕ БАЗЫ ДАННЫХ И ТАБЛИЦ")
        
//        let filepath = TestsData.getFilepath(prefix: "TodoList_", withDatetime: true)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
        print("************************************************************************\n")
    }
    
    // MARK: - Tests getAll()
    func tests_GetAll() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ЗАГРУЗКА ВСЕХ ЗАПИСЕЙ ИЗ ТАБЛИЦЫ")
        
//        _ = coreDataManager.load()

        let items = coreDataManager.getAll()
        print("Количество записей в таблице: \(items.count)")

        for item in items { print("  \(item)") }
        print("************************************************************************\n")
    }

//    // MARK: - Tests get()
//    func tests_GetById_IdNotFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: ЗАГРУЗКА КОНКРЕТНОЙ ЗАПИСИ ИЗ ТАБЛИЦЫ КОГДА ИДЕНТИФИКАТОР НЕ НАЙДЕН")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        let items = coreDataManager.getAll()
//        print("Количество записей в таблице: \(items.count)")
//
//        let id = UUID().uuidString
//        print("Идентификатор для получения записи: \(id)")
//
//        let item = coreDataManager.get(by: id)
//        XCTAssertNil(item)
//        print("Результат получения конкретной записи: \(String(describing: item))")
//        print("************************************************************************\n")
//    }
//
//    func tests_GetById_IdFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: ЗАГРУЗКА КОНКРЕТНОЙ ЗАПИСИ ИЗ ТАБЛИЦЫ КОГДА ИДЕНТИФИКАТОР НАЙДЕН")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        let items = coreDataManager.getAll()
//        print("Количество записей в таблице: \(items.count)")
//
//        let id = items[0].id
//        print("Идентификатор для получения записи: \(id)")
//
//        let item = coreDataManager.get(by: id)
//        XCTAssertNotNil(item)
//        print("Результат получения конкретной записи: \(String(describing: item))")
//        print("************************************************************************\n")
//    }
//
    // MARK: - Tests insert()
    func tests_Insert_IdNotFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ЗАПИСЕЙ С НОВЫМИ ИДЕНТИФИКАТОРАМИ")
        
        var count = coreDataManager.getAll().count
        print("Количество записей в таблице до операции INSERT: \(count)")

        for _ in count...(count + 5) {
            let item = TodoList()
            _ = coreDataManager.insert(item)
        }
        
        let allItems = coreDataManager.getAll()
        allItems.map({ print($0) })

        print("Количество записей в таблице после опреации INSERT: \(allItems.count)")
        print("Количество добавленных записей в таблицу: \(allItems.count - count)")
        print("************************************************************************\n")
    }

    // MARK: - Tests update()
    func tests_Update_IdNotFound() throws {
        print("\n******************************** ТЕСТ *********************************")
        print("ПРОВЕРКА: ОБНОВЛЕНИЕ ЗАПИСЕЙ С НЕСОВПАДАЮЩИМИСЯ ИДЕНТИФИКАТОРАМИ")
        
        let items = coreDataManager.getAll()
        print("Количество записей в таблице до операции UPDATE: \(items.count)")
        var count = 0
        for _ in 0...5 {
            let item = TodoList()
            let updateResult = coreDataManager.update(item)
            if updateResult != nil { count += 1 }
        }

        _ = coreDataManager.save()
        _ = coreDataManager.load()
        let allCount = coreDataManager.getAll().count

        print("Количество записей в таблице после операции UPDATE: \(allCount)")
        print("Количество обновленных записей в таблице: \(count)")
        print("************************************************************************\n")
    }
//
//    func tests_Update_IdFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: ОБНОВЛЕНИЕ ЗАПИСЕЙ С СОВПАДАЮЩИМИСЯ ИДЕНТИФИКАТОРАМИ")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        var count = 0
//        let items = coreDataManager.getAll()
//        print("Количество записей в таблице до операции UPDATE: \(items.count)")
//
//        for item in items {
//            let updatedItem = TodoList(id: item.id, items: item.items, revision: item.revision + 1,
//                                       isDirty: item.isDirty, lastUpdatedBy: "simulator", lastUpdatedOn: Date())
//            let updateResult = coreDataManager.update(updatedItem)
//            if updateResult != nil { count += 1 }
//        }
//
//        _ = coreDataManager.save()
//        _ = coreDataManager.load()
//        let allCount = coreDataManager.getAll().count
//
//        print("Количество записей в таблице после операции UPDATE: \(allCount)")
//        print("Количество обновленных записей в таблице: \(count)")
//        print("************************************************************************\n")
//    }
//
//    // MARK: - Tests insertOrUpdate()
//    func tests_InsertOrUpdate_IdNotFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ИЛИ ОБНОВЛЕНИЕ ЗАПИСЕЙ С НЕСОВПАДАЮЩИМИСЯ ИДЕНТИФИКАТОРАМИ")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        let items = coreDataManager.getAll()
//        var count = items.count
//        print("Количество записей в таблице до операции UPSERT: \(count)")
//
//        for _ in count...(count + 5) {
//            let item = TodoList()
//            _ = coreDataManager.upsert(item)
//        }
//
//        _ = coreDataManager.save()
//        _ = coreDataManager.load()
//        let allCount = coreDataManager.getAll().count
//
//        print("Количество записей в таблице после операции UPSERT: \(allCount)")
//        print("Количество добавленных записей: \(allCount - count)")
//        print("************************************************************************\n")
//    }
//
//    func tests_InsertOrUpdate_IdFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: ДОБАВЛЕНИЕ ИЛИ ОБНОВЛЕНИЕ ЗАПИСЕЙ С ОДИНАКОВЫМИ ИДЕНТИФИКАТОРАМИ")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        let items = coreDataManager.getAll()
//        var count = items.count
//        print("Количество записей в таблице до операций UPSERT: \(count)")
//
//        for item in items {
//            let newItem = TodoList(id: item.id, items: item.items, revision: item.revision + 1,
//                                   isDirty: item.isDirty, lastUpdatedBy: "simulator", lastUpdatedOn: Date())
//            _ = coreDataManager.upsert(newItem)
//        }
//
//        _ = coreDataManager.save()
//        _ = coreDataManager.load()
//        let allCount = coreDataManager.getAll().count
//
//        print("Количество записей в таблице после операции UPSERT: \(allCount)")
//        print("Количество добавленных в таблице: \(allCount - count)")
//        print("************************************************************************\n")
//    }
//
//    // MARK: - Tests delete()
//    func tests_Delete_IdNotFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: УДАЛЕНИЕ ЗАПИСЕЙ КОГДА ИНДЕТИФИКАТОРЫ НЕ СОВПАДАЮТ")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        var count = coreDataManager.getAll().count
//        print("Количество записей в таблице до выполенения операций DELETE: \(count)")
//
//        for idx in 1...count where idx % 2 == 0 {
//            let newItem = TodoList()
//            _ = coreDataManager.delete(by: newItem.id)
//        }
//
//        _ = coreDataManager.save()
//        _ = coreDataManager.load()
//        let allCount = coreDataManager.getAll().count
//
//        print("Количество записей в таблице после операции DELETE: \(allCount)")
//        print("Количество удаленных записей в таблице: \(count - allCount)")
//        print("************************************************************************\n")
//    }
//
//    func tests_Delete_IdIsFound() throws {
//        print("\n******************************** ТЕСТ *********************************")
//        print("ПРОВЕРКА: УДАЛЕНИЕ ЗАПИСЕЙ КОГДА ИНДЕТИФИКАТОРЫ СОВПАДАЮТ")
//
//        let filepath = TestsData.getFilepath(prefix: "TodoList", isTemp: false)
//        coreDataManager.configure(name: filepath.filename, connectionUrl: filepath.url)
//        _ = coreDataManager.load()
//
//        let items = coreDataManager.getAll()
//        let count = items.count
//        print("Количество записей в таблице до операций DELETE: \(count)")
//
//        for idx in 0..<count where idx % 2 == 0 {
//            _ = coreDataManager.delete(by: items[idx].id)
//        }
//
//        _ = coreDataManager.save()
//        _ = coreDataManager.load()
//        let allCount = coreDataManager.getAll().count
//
//        print("Количество записей в таблице : \(allCount)")
//        print("Количество удаленных записей в таблице : \(count - allCount)")
//        print("************************************************************************\n")
//    }
}

