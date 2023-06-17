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
    static let id2 = "A5A600C6-9B8F-4B36-AD55-F49B3D55C978"
    
    static let createdOn = Date(timeIntervalSince1970: TimeInterval(168655000))
    static let updatedOn = Date(timeIntervalSince1970: TimeInterval(168656000))
    static let deadline = Date(timeIntervalSince1970: TimeInterval(168660000))
    
    static let createdOnTime = createdOn.datetime
    static let updatedOnTime = updatedOn.datetime
    static let deadlineTime = deadline.datetime
    
    static let testCases_ForInit = testCases_DeadlineAndUpdatedOn_IsNil + testCases_Filled + testCases_Deadline_IsNil + testCases_UpdatedOn_IsNil
    
    static let testCases_DeadlineAndUpdatedOn_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?, csv: String)] = [
        ("DC0419AE-8DF7-4847-863D-FB2D67F8DDD8", "test 1; test 1.2, 1.3|4;", .medium, nil, false, createdOn, nil,
         "\"DC0419AE-8DF7-4847-863D-FB2D67F8DDD8\";\"test 1; test 1.2, 1.3|4;\";;;false;\(createdOnTime);;"),
        
        ("D795D0ED-A198-42EC-97C1-BF2515DAC721", "test 2", .high,   nil, false, createdOn, nil ,
         "\"D795D0ED-A198-42EC-97C1-BF2515DAC721\";\"test 2\";high;;false;\(createdOnTime);;"),
        
        ("EE53C13D-3BED-461F-A4CC-18F3A631B6A5", "test 3", .low,    nil, false, createdOn, nil ,
         "\"EE53C13D-3BED-461F-A4CC-18F3A631B6A5\";\"test 3\";low;;false;\(createdOnTime);;"),
        
        ("2FE2478D-7A78-456F-90E5-9C15F5868210", "test 4", .medium, nil, true, createdOn, nil,
         "\"2FE2478D-7A78-456F-90E5-9C15F5868210\";\"test 4\";;;true;\(createdOnTime);;"),
        
        ("79B486E7-1EBE-471F-806D-91339BF511DB", "test 5", .high,   nil, true, createdOn, nil,
         "\"79B486E7-1EBE-471F-806D-91339BF511DB\";\"test 5\";high;;true;\(createdOnTime);;"),
        
        ("D4B6D237-F550-402E-AAFA-10D90D7AD754", "test 6", .low,    nil, true, createdOn, nil,
         "\"D4B6D237-F550-402E-AAFA-10D90D7AD754\";\"test 6\";\"low;;true;\(createdOnTime);;"),
    ]
    
    static let testCases_UpdatedOn_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?, csv: String)] = [
        ("5F3D0A17-3C5D-4F5B-993B-A5CF5DABB596", "test 7", .medium, deadline, false, createdOn, nil,
         "\"5F3D0A17-3C5D-4F5B-993B-A5CF5DABB596\";\"test 7\";;\(deadlineTime);false;\(createdOnTime);;"),
        
        ("C9662404-0DFE-400D-BE07-ED5476BAF6D9", "test 8", .high,   deadline, false, createdOn, nil,
         "\"C9662404-0DFE-400D-BE07-ED5476BAF6D9\";\"test 8\"high;\(deadlineTime);false;\(createdOnTime);;"),
        
        ("E04828BF-157C-4CD7-BF99-52EB4AD30729", "test 9", .low,    deadline, false, createdOn, nil,
         "\"E04828BF-157C-4CD7-BF99-52EB4AD30729\";\"test 9\";low;\(deadlineTime);false;\(createdOnTime);;"),
        
        ("0414F7C2-B9FF-4388-9B55-7360D191FCA1", "test 10", .medium, deadline, true, createdOn, nil,
         "\"0414F7C2-B9FF-4388-9B55-7360D191FCA1\";\"test 10\";;\(deadlineTime);true;\(createdOnTime);;"),
        
        ("3FE3EB20-D7A7-4A0D-BA67-7A789E1567AC", "test 11", .high,   deadline, true, createdOn, nil,
         "\"3FE3EB20-D7A7-4A0D-BA67-7A789E1567AC\";\"test 11\";high;\(deadlineTime);true;\(createdOnTime);;"),
        
        ("46698208-DCAF-4C60-8D22-419239945A7E", "test 12", .low,    deadline, true, createdOn, nil,
         "\"46698208-DCAF-4C60-8D22-419239945A7E\";\"test 12\";low;\(deadlineTime);true;\(createdOnTime);;"),
    ]
    
    static let testCases_Deadline_IsNil: [(id: String, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?, csv: String)] = [
        ("66FE2F28-E567-49AF-9D0B-8132FEBF3C30", "test 13", .medium, nil, false, createdOn, updatedOn,
         "\"66FE2F28-E567-49AF-9D0B-8132FEBF3C30\";\"test 13\";;;false;\(createdOnTime);\(updatedOnTime);"),
        
        ("66839245-1057-4B7B-A651-2CCD3407E3B7", "test 14", .high,   nil, false, createdOn, updatedOn,
         "\"66839245-1057-4B7B-A651-2CCD3407E3B7\";\"test 14\";high;;false;\(createdOnTime);\(updatedOnTime);"),
        
        ("778FD0B0-6D0C-49D2-8540-EF58D6C05BF7", "test 15", .low,    nil, false, createdOn, updatedOn,
         "\"778FD0B0-6D0C-49D2-8540-EF58D6C05BF7\";\"test 15\";low;;false;\(createdOnTime);\(updatedOnTime);"),
        
        ("079044AB-835C-4712-9727-8830E45A3F52", "test 16", .medium, nil, true, createdOn, updatedOn,
         "\"079044AB-835C-4712-9727-8830E45A3F52\";\"test 16\";;;true;\(createdOnTime);\(updatedOnTime);"),
        
        ("34AD0A5D-2973-4DBA-90EA-0C5A40324126", "test 17", .high,   nil, true, createdOn, updatedOn,
         "\"34AD0A5D-2973-4DBA-90EA-0C5A40324126\";\"test 17\";high;;true;\(createdOnTime);\(updatedOnTime);"),
        
        ("EBD99C9D-934A-42AC-A460-507B41A95B76", "test 18", .low,    nil, true, createdOn, updatedOn,
         "\"EBD99C9D-934A-42AC-A460-507B41A95B76\";\"test 18\";low;;true;\(createdOnTime);\(updatedOnTime);"),
        
    ]
    
    static let testCases_Filled: [(id: String, text: String, priority: Priority, deadline: Date?, isDone: Bool, createdOn: Date, updatedOn: Date?, csv: String)] = [
        ("86FFE8B6-392C-4B56-A0A5-9068EA2DB83E", "test 19", .medium, deadline, false, createdOn, updatedOn,
         "\"86FFE8B6-392C-4B56-A0A5-9068EA2DB83E\";\"test 19\";;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"),
        
        ("113F3BC1-2B96-4A3B-9D0F-BFC3CFF3C3AC", "test 20", .high,   deadline, false, createdOn, updatedOn,
         "\"113F3BC1-2B96-4A3B-9D0F-BFC3CFF3C3AC\";\"test 20\";high;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"),
        
        ("90ECAD81-C5E8-4A88-A246-4A6C2689BE63", "test 21", .low,    deadline, false, createdOn, updatedOn,
         "\"90ECAD81-C5E8-4A88-A246-4A6C2689BE63\";\"test 21\";low;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"),
        
        ("A42AE962-14A5-48A4-A48D-A2F81CE81FB3", "test 22", .medium, deadline, true, createdOn, updatedOn,
         "\"A42AE962-14A5-48A4-A48D-A2F81CE81FB3\";\"test 22\";;\(deadlineTime);true;\(createdOnTime);\(updatedOnTime);"),
        
        ("7EBC7227-0F22-4A95-BA75-9AA854A81FC5", "test 23", .high,   deadline, true, createdOn, updatedOn,
         "\"7EBC7227-0F22-4A95-BA75-9AA854A81FC5\";\"test 23\";high;\(deadlineTime);true;\(createdOnTime);\(updatedOnTime);"),
        
        ("840E3E53-96FD-4DC5-9515-BFE7B4B76449", "test 24", .low,    deadline, true, createdOn, updatedOn,
         "\"840E3E53-96FD-4DC5-9515-BFE7B4B76449\";\"test 24\";low;\(deadlineTime);true;\(createdOnTime);\(updatedOnTime);"),
    ]

    
    static let testCases_ParseJson_Id_Invalid: [[String: Any]] = [
        ["id": 1, "text": "id is Int()", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": false, "text": "id is boolean", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": Date(), "text": "id Date()", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": 1.5 , "text": "id is Double()", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": [String: Any](), "text": "id is [String: Any]()", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "", "text": "id is empty string", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "sajdnaksfnklnckzjnvkzjnd", "text": "id is short string", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": "sajdnaksfnklncsdjnskjnksncljasnvckjskzjnvkzjnd", "text": "id is long string", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["text": "id undefined", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Id_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "1;\"id is Int()\";low;168655000;false;168655000;168655000;\n" +
    "false;\"id is boolean\";low;168655000;false;168655000;168655000;\n" +
    "Date()\"id is Date()\";low;168655000;false;168655000;168655000;\n" +
    "1.5\"id is Double()\";low;168655000;false;168655000;168655000;\n" +
    "[String: Any]();\"id is [String: Any]()\";low;168655000;false;168655000;168655000;\n" +
    "\"\";\"id is empty string\";low;168655000;false;168655000;168655000;\n" +
    "\"sajdnaksfnklnckzjnvkzjnd\";\"id is short string\";low;168655000;false;168655000;168655000;\n" +
    "\"sajdnaksfnklncsdjnskjnksncljasnvckjskzjnvkzjnd\";\"id is long string\";low;68655000;false;168655000;168655000;\n" +
    ";\"id undefined\";low;168655000;false;168655000;168655000;"
    
    
    static let testCases_ParseJson_Id_Valid: [[String: Any]] = [
        ["id": id, "text": "id valid", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id2, "text": "id valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000]
    ]
    
    static let testCases_ParseCsv_Id_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"id valid\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id2)\";\"id valid 2\";low;168655000;false;168655000;168655000;"
    
    
    static let testCases_ParseJson_Text_Invalid: [[String: Any]] = [
        ["id": id, "text": 1, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": false, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": Date(), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": 1.5, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": [String: Any](), "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Text_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";1;low;168655000;false;68655000;168655000;\n" +
    "\"\(id)\";false;low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";Date();low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";1.5;low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";[String: Any]();low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";;low;168655000;false;168655000;168655000;"
    
    static let testCases_ParseJson_Text_Valid: [[String: Any]] = [
        ["id": id, "text": "text valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "   ", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Text_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"text valid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"   \";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"\";low;168655000;false;168655000;168655000;"
    
    
    static let testCases_ParseJson_Priority_Invalid: [[String: Any]] = [
        ["id": id, "text": "priority invalid 1", "priority": 8, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 2", "priority": "hard", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 3", "priority": "   ", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 4", "priority": "", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 5", "priority": false, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 6", "priority": Date(), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 7", "priority": 1.5, "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority invalid 8", "priority": [String: Any](), "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Priority_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"priority invalid 1\";8;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 2\";hard;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 3\";\"   \";168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 4\";\"\";168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 5\";false;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 6\";Date();168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 7\";1.5;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority invalid 8\";[String: Any]();168655000;false;168655000;168655000;"
    
    
    static let testCases_ParseJson_Priority_Valid: [[String: Any]] = [
        ["id": id, "text": "priority valid 1", "priority": "medium", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 2", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 3", "priority": "high", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "priority valid 4", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Priority_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"priority valid 1\";medium;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority valid 2\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority valid 3\";high;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"priority valid 4\";168655000;false;168655000;168655000;"
    
    static let testCases_ParseJson_Deadline_Invalid: [[String: Any]] = [
        ["id": id, "text": "deadline invalid 1", "priority": "low", "deadline": "168655000", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 2", "priority": "high", "deadline": "   ", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 3", "priority": "high", "deadline": "", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 4", "priority": "low", "deadline": false, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 5", "priority": "high", "deadline": Date(), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 6", "priority": "low", "deadline": [String: Any](), "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline invalid 7", "priority": "high", "deadline": 168655000.55, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Deadline_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"deadline invalid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 2\";high;   ;false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 3\";high;  ;false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 4\";low;false;false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 5\";high;Date();false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 6\";low;[String: Any]();false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline invalid 7\";high;168655000.55;false;168655000;168655000;"
    
    static let testCases_ParseJson_Deadline_Valid: [[String: Any]] = [
        ["id": id, "text": "deadline valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "deadline valid 2", "priority": "low", "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_Deadline_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"deadline valid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"deadline valid 2\";low;false;168655000;168655000;"
    
    static let testCases_ParseJson_IsDone_Invalid: [[String: Any]] = [
        ["id": id, "text": "isDone invalid 1", "priority": "low", "deadline": 168655000, "isDone": "false", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 2", "priority": "low", "deadline": 168655000, "isDone": "  ", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 3", "priority": "low", "deadline": 168655000, "isDone": "", "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 4", "priority": "low", "deadline": 168655000, "isDone": 1, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 5", "priority": "low", "deadline": 168655000, "isDone": 1.5, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 6", "priority": "low", "deadline": 168655000, "isDone": Date(), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 7", "priority": "low", "deadline": 168655000, "isDone": [String: Any](), "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone invalid 8", "priority": "low", "deadline": 168655000, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static  let testCases_ParseCsv_IsDone_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"isDone invalid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 2\";low;168655000;  ;168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 3\";low;168655000; ;168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 4\";low;168655000;1;168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 5\";low;168655000;1.5;168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 6\";low;168655000;Date();168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 7\";low;168655000;[String: Any]();168655000;168655000;\n" +
    "\"\(id)\";\"isDone invalid 8\";low;168655000,;168655000;168655000;"
    
    static let testCases_ParseJson_IsDone_Valid: [[String: Any]] = [
        ["id": id, "text": "isDone valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "isDone valid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static  let testCases_ParseCsv_IsDone_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"isDone valid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"isDone valid 2\";low;168655000;true;168655000;168655000;"
    
    static let testCases_ParseJson_CreatedOn_Invalid: [[String: Any]] = [
        ["id": id, "text": "createdOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": "168655000", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "   ", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": "", "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": Date(), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": false, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": [String: Any](), "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000.55, "updatedOn": 168655000],
        ["id": id, "text": "createdOn invalid 8", "priority": "low", "deadline": 168655000, "isDone": true, "updatedOn": 168655000],
    ]
    
    static let testCases_ParseCsv_CreatedOn_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"createdOn invalid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"createdOn invalid 2\";low;168655000;true;   ;168655000;\n" +
    "\"\(id)\";\"createdOn invalid 3\";low;168655000;true;  ;168655000;\n" +
    "\"\(id)\";\"createdOn invalid 4\";low;168655000;true;Date();168655000;\n" +
    "\"\(id)\";\"createdOn invalid 5\";low;168655000;true;alse;68655000;\n" +
    "\"\(id)\";\"createdOn invalid 6\";low;168655000;true;[String: Any]();168655000;\n" +
    "\"\(id)\";\"createdOn invalid 7\";low;168655000;true;168655000.55;168655000;\n" +
    "\"\(id)\";\"createdOn invalid 8\";low;168655000;true;168655000;"
    
    static let testCases_ParseJson_CreatedOn_Valid: [[String: Any]] = [
        ["id": id, "text": "createdOn valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
    ]
    
    static  let testCases_ParseCsv_CreatedOn_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"createdOn valid 1\";low;168655000;false;168655000;168655000;"
    
    
    static let testCases_ParseJson_UpdatedOn_Invalid: [[String: Any]] = [
        ["id": id, "text": "updatedOn invalid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": "168655000"],
        ["id": id, "text": "updatedOn invalid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": "   "],
        ["id": id, "text": "updatedOn invalid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": ""],
        ["id": id, "text": "updatedOn invalid 4", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": Date()],
        ["id": id, "text": "updatedOn invalid 5", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": false],
        ["id": id, "text": "updatedOn invalid 6", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": [String: Any]()],
        ["id": id, "text": "updatedOn invalid 7", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000.55],
    ]
    
    static let testCases_ParseCsv_UpdatedOn_Invalid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"updatedOn invalid 1\";low;168655000;false;68655000;168655000;\n" +
    "\"\(id)\";\"updatedOn invalid 2\";low;168655000;true;168655000;    ;\n" +
    "\"\(id)\";\"updatedOn invalid 3\";low;168655000;true;168655000;  ;\n" +
    "\"\(id)\";\"updatedOn invalid 4\";low;168655000;true;168655000;Date();\n" +
    "\"\(id)\";\"updatedOn invalid 5\";low;168655000;true;168655000;false;\n" +
    "\"\(id)\";\"updatedOn invalid 6\";low;168655000;true;168655000;[String: Any]();\n" +
    "\"\(id)\";\"updatedOn invalid 7\";low;168655000;false;168655000;168655000.55;"
    
    static let testCases_ParseJson_UpdatedOn_Valid: [[String: Any]] = [
        ["id": id, "text": "test, updatedOn valid 1", "priority": "low", "deadline": 168655000, "isDone": false, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test, updatedOn valid 2", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000, "updatedOn": 168655000],
        ["id": id, "text": "test, updatedOn valid 3", "priority": "low", "deadline": 168655000, "isDone": true, "createdOn": 168655000],
    ]
    
    static let testCases_ParseCav_UpdatedOn_Valid = "id;text;priority;deadline;isDone;createdOn;updatedOn;\n" +
    "\"\(id)\";\"updatedOn valid 1\";low;168655000;false;168655000;168655000;\n" +
    "\"\(id)\";\"updatedOn valid 2\";low;168655000;true;168655000;168655000;\n" +
    "\"\(id)\";\"updatedOn valid 3\";low;168655000;true;168655000;"
}
