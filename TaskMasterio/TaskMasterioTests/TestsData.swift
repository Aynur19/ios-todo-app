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
    
    static let testCases_DeadlineAndUpdatedOn_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?,
                                                       isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("DC0419AE-8DF7-4847-863D-FB2D67F8DDD8", "test 1", .medium, nil, false, createdOn, nil),
        ("D795D0ED-A198-42EC-97C1-BF2515DAC721", "test 2", .high,   nil, false, createdOn, nil),
        ("EE53C13D-3BED-461F-A4CC-18F3A631B6A5", "test 3", .low,    nil, false, createdOn, nil),
        
        ("2FE2478D-7A78-456F-90E5-9C15F5868210", "test 4", .medium, nil, true, createdOn, nil),
        ("79B486E7-1EBE-471F-806D-91339BF511DB", "test 5", .high,   nil, true, createdOn, nil),
        ("D4B6D237-F550-402E-AAFA-10D90D7AD754", "test 6", .low,    nil, true, createdOn, nil),
    ]
    
    static let testCases_UpdatedOn_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?,
                                            isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("5F3D0A17-3C5D-4F5B-993B-A5CF5DABB596", "test 7", .medium, deadline, false, createdOn, nil),
        ("C9662404-0DFE-400D-BE07-ED5476BAF6D9", "test 8", .high,   deadline, false, createdOn, nil),
        ("E04828BF-157C-4CD7-BF99-52EB4AD30729", "test 9", .low,    deadline, false, createdOn, nil),
        
        ("0414F7C2-B9FF-4388-9B55-7360D191FCA1", "test 10", .medium, deadline, true, createdOn, nil),
        ("3FE3EB20-D7A7-4A0D-BA67-7A789E1567AC", "test 11", .high,   deadline, true, createdOn, nil),
        ("46698208-DCAF-4C60-8D22-419239945A7E", "test 12", .low,    deadline, true, createdOn, nil),
    ]
    
    static let testCases_Deadline_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?,
                                           isDone: Bool, createdOn: Date, updatedOn: Date?)] = [
        ("66FE2F28-E567-49AF-9D0B-8132FEBF3C30", "test 13", .medium, nil, false, createdOn, updatedOn),
        ("66839245-1057-4B7B-A651-2CCD3407E3B7", "test 14", .high,   nil, false, createdOn, updatedOn),
        ("778FD0B0-6D0C-49D2-8540-EF58D6C05BF7", "test 15", .low,    nil, false, createdOn, updatedOn),
        
        ("079044AB-835C-4712-9727-8830E45A3F52", "test 16", .medium, nil, true, createdOn, updatedOn),
        ("34AD0A5D-2973-4DBA-90EA-0C5A40324126", "test 17", .high,   nil, true, createdOn, updatedOn),
        ("EBD99C9D-934A-42AC-A460-507B41A95B76", "test 18", .low,    nil, true, createdOn, updatedOn),
        
    ]
    
    static let testCases_Filled: [(id: String, text: String, priority: Priority, deadline: Date?, isDone: Bool,
                                   createdOn: Date, updatedOn: Date?)] = [
        ("86FFE8B6-392C-4B56-A0A5-9068EA2DB83E", "test 19", .medium, deadline, false, createdOn, updatedOn),
        ("113F3BC1-2B96-4A3B-9D0F-BFC3CFF3C3AC", "test 20", .high,   deadline, false, createdOn, updatedOn),
        ("90ECAD81-C5E8-4A88-A246-4A6C2689BE63", "test 21", .low,    deadline, false, createdOn, updatedOn),
        
        ("A42AE962-14A5-48A4-A48D-A2F81CE81FB3", "test 22", .medium, deadline, true, createdOn, updatedOn),
        ("7EBC7227-0F22-4A95-BA75-9AA854A81FC5", "test 23", .high,   deadline, true, createdOn, updatedOn),
        ("840E3E53-96FD-4DC5-9515-BFE7B4B76449", "test 24", .low,    deadline, true, createdOn, updatedOn),
    ]
    
    static let testCases_Id_Nil = testCases_DeadlineAndUpdatedOn_IsNil + testCases_Filled +
                                  testCases_Deadline_IsNil + testCases_UpdatedOn_IsNil
}
