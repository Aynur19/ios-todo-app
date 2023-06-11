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


