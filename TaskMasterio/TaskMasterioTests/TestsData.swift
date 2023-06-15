//
//  TestsData.swift
//  TaskMasterioTests
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation
@testable import TaskMasterio

struct TestsData {
    static let id = "A5A600C6-9B8F-4B36-AD55-F49B3D55C975"
    static let createdOn = Date(timeIntervalSince1970: TimeInterval(168655000))
    static let updatedOn = Date(timeIntervalSince1970: TimeInterval(168656000))
    static let deadline = Date(timeIntervalSince1970: TimeInterval(168660000))
    
    static let testCases_DeadlineAndUpdatedOn_IsNil: [(text: String, priority: Priority, deadline: Date?,
                                                       isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("test 1", .medium, nil, false, createdOn, nil),
        ("test 2", .high,   nil, false, createdOn, nil),
        ("test 3", .low,    nil, false, createdOn, nil),
        
        ("test 4", .medium, nil, true, createdOn, nil),
        ("test 5", .high,   nil, true, createdOn, nil),
        ("test 6", .low,    nil, true, createdOn, nil),
    ]
    
    static let testCases_UpdatedOn_IsNil: [(text: String, priority: Priority, deadline: Date?, isDone: Bool,
                                            createdOn: Date, updatedOn: Date?)] = [
        ("test 7", .medium, deadline, false, createdOn, nil),
        ("test 8", .high,   deadline, false, createdOn, nil),
        ("test 9", .low,    deadline, false, createdOn, nil),
        
        ("test 10", .medium, deadline, true, createdOn, nil),
        ("test 11", .high,   deadline, true, createdOn, nil),
        ("test 12", .low,    deadline, true, createdOn, nil),
    ]
    
    static let testCases_Deadline_IsNil: [(text: String, priority: Priority, deadline: Date?, isDone: Bool,
                                           createdOn: Date, updatedOn: Date?)] = [
        ("test 13", .medium, nil, false, createdOn, updatedOn),
        ("test 14", .high,   nil, false, createdOn, updatedOn),
        ("test 15", .low,    nil, false, createdOn, updatedOn),
        
        ("test 16", .medium, nil, true, createdOn, updatedOn),
        ("test 17", .high,   nil, true, createdOn, updatedOn),
        ("test 18", .low,    nil, true, createdOn, updatedOn),
        
    ]
    
    static let testCases_Filled: [(text: String, priority: Priority, deadline: Date?, isDone: Bool,
                                   createdOn: Date, updatedOn: Date?)] = [
        ("test 19", .medium, deadline, false, createdOn, updatedOn),
        ("test 20", .high,   deadline, false, createdOn, updatedOn),
        ("test 21", .low,    deadline, false, createdOn, updatedOn),
        
        ("test 22", .medium, deadline, true, createdOn, updatedOn),
        ("test 23", .high,   deadline, true, createdOn, updatedOn),
        ("test 24", .low,    deadline, true, createdOn, updatedOn),
    ]
    
    static let testCases_Id_Nil = testCases_DeadlineAndUpdatedOn_IsNil + testCases_Filled +
                                  testCases_Deadline_IsNil + testCases_UpdatedOn_IsNil
}
