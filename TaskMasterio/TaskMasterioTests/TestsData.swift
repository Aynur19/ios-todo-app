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
    
    static let createdOn =  Date(timeIntervalSince1970: TimeInterval(168655000))
    static let updatedOn = Date(timeIntervalSince1970: TimeInterval(168656000))
    static let deadline = Date(timeIntervalSince1970: TimeInterval(168660000))

    static let createdOnTime =  createdOn.datetime
    static let updatedOnTime = updatedOn.datetime
    static let deadlineTime = deadline.datetime
    
    static func getFilepath(prefix: String, withDatetime: Bool = false, isTemp: Bool = true) -> (filename: String, url: URL) {
        var filename: String
        
        if withDatetime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DatetimeFormats.yyyyMMddTHHmmss
            filename = "\(prefix)(\(dateFormatter.string(from: Date())))"
        } else {
            filename = prefix
        }

        var testDirUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appending(component: "TestFiles")
        if isTemp { testDirUrl.append(component: "Generated") }
        
        return (filename, testDirUrl)
    }

    static let forInit = deadlineAndUpdatedOnIsNil + filled + deadlineIsNil + updatedOnIsNil

    static let deadlineAndUpdatedOnIsNil: [(item: TodoItem, csv: String)] = [
        (
            TodoItem(id: "DC0419AE-8DF7-4847-863D-FB2D67F8DDD8",
                     text: "test 1; test 1.2, 1.3|4;",
                     priority: .medium,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"DC0419AE-8DF7-4847-863D-FB2D67F8DDD8\";\"test 1; test 1.2, 1.3|4;\";;;false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "D795D0ED-A198-42EC-97C1-BF2515DAC721",
                     text: "test 2",
                     priority: .high,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"D795D0ED-A198-42EC-97C1-BF2515DAC721\";\"test 2\";high;;false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "EE53C13D-3BED-461F-A4CC-18F3A631B6A5",
                     text: "test 3",
                     priority: .low,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"EE53C13D-3BED-461F-A4CC-18F3A631B6A5\";\"test 3\";low;;false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "2FE2478D-7A78-456F-90E5-9C15F5868210",
                     text: "test 4",
                     priority: .medium,
                     deadline: nil,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"2FE2478D-7A78-456F-90E5-9C15F5868210\";\"test 4\";;;true;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "79B486E7-1EBE-471F-806D-91339BF511DB",
                     text: "test 5",
                     priority: .high,
                     deadline: nil,  
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"79B486E7-1EBE-471F-806D-91339BF511DB\";\"test 5\";high;;true;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "D4B6D237-F550-402E-AAFA-10D90D7AD754",
                     text: "test 6",
                     priority: .low,
                     deadline: nil,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"D4B6D237-F550-402E-AAFA-10D90D7AD754\";\"test 6\";low;;true;\(createdOnTime);;"
        )
    ]

    static let updatedOnIsNil: [(item: TodoItem, csv: String)] = [
        (
            TodoItem(id: "5F3D0A17-3C5D-4F5B-993B-A5CF5DABB596",
                     text: "test 7",
                     priority: .medium,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"5F3D0A17-3C5D-4F5B-993B-A5CF5DABB596\";\"test 7\";;\(deadlineTime);false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "C9662404-0DFE-400D-BE07-ED5476BAF6D9",
                     text: "test 8",
                     priority: .high,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"C9662404-0DFE-400D-BE07-ED5476BAF6D9\";\"test 8\";high;\(deadlineTime);false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "E04828BF-157C-4CD7-BF99-52EB4AD30729",
                     text: "test 9",
                     priority: .low,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"E04828BF-157C-4CD7-BF99-52EB4AD30729\";\"test 9\";low;\(deadlineTime);false;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "0414F7C2-B9FF-4388-9B55-7360D191FCA1",
                     text: "test 10",
                     priority: .medium,
                     deadline: deadline,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"0414F7C2-B9FF-4388-9B55-7360D191FCA1\";\"test 10\";;\(deadlineTime);true;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "3FE3EB20-D7A7-4A0D-BA67-7A789E1567AC",
                     text: "test 11",
                     priority: .high,
                     deadline: deadline,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"3FE3EB20-D7A7-4A0D-BA67-7A789E1567AC\";\"test 11\";high;\(deadlineTime);true;\(createdOnTime);;"
        ),
        (
            TodoItem(id: "46698208-DCAF-4C60-8D22-419239945A7E",
                     text: "test 12",
                     priority: .low,
                     deadline: deadline,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: nil),
            "\"46698208-DCAF-4C60-8D22-419239945A7E\";\"test 12\";low;\(deadlineTime);true;\(createdOnTime);;"
        )
    ]

    static let deadlineIsNil: [(item: TodoItem, csv: String)] = [
        (
            TodoItem(id: "66FE2F28-E567-49AF-9D0B-8132FEBF3C30",
                     text: "test 13",
                     priority: .medium,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"66FE2F28-E567-49AF-9D0B-8132FEBF3C30\";\"test 13\";;;false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "66839245-1057-4B7B-A651-2CCD3407E3B7",
                     text: "test 14",
                     priority: .high,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"66839245-1057-4B7B-A651-2CCD3407E3B7\";\"test 14\";high;;false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "778FD0B0-6D0C-49D2-8540-EF58D6C05BF7",
                     text: "test 15",
                     priority: .low,
                     deadline: nil,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"778FD0B0-6D0C-49D2-8540-EF58D6C05BF7\";\"test 15\";low;;false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "079044AB-835C-4712-9727-8830E45A3F52",
                     text: "test 16",
                     priority: .medium,
                     deadline: nil,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"079044AB-835C-4712-9727-8830E45A3F52\";\"test 16\";;;true;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "34AD0A5D-2973-4DBA-90EA-0C5A40324126",
                     text: "test 17",
                     priority: .high,
                     deadline: nil,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"34AD0A5D-2973-4DBA-90EA-0C5A40324126\";\"test 17\";high;;true;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "EBD99C9D-934A-42AC-A460-507B41A95B76",
                     text: "test 18",
                     priority: .low,
                     deadline: nil,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"EBD99C9D-934A-42AC-A460-507B41A95B76\";\"test 18\";low;;true;\(createdOnTime);\(updatedOnTime);"
        )
    ]

    static let filled: [(item: TodoItem, csv: String)] = [
        (
            TodoItem(id: "86FFE8B6-392C-4B56-A0A5-9068EA2DB83E",
                     text: "test 19",
                     priority: .medium,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"86FFE8B6-392C-4B56-A0A5-9068EA2DB83E\";\"test 19\";;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "113F3BC1-2B96-4A3B-9D0F-BFC3CFF3C3AC",
                     text: "test 20",
                     priority: .high,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"113F3BC1-2B96-4A3B-9D0F-BFC3CFF3C3AC\";\"test 20\";high;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "90ECAD81-C5E8-4A88-A246-4A6C2689BE63",
                     text: "test 21",
                     priority: .low,
                     deadline: deadline,
                     isDone: false,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"90ECAD81-C5E8-4A88-A246-4A6C2689BE63\";\"test 21\";low;\(deadlineTime);false;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "A42AE962-14A5-48A4-A48D-A2F81CE81FB3",
                     text: "test 22",
                     priority: .medium,
                     deadline: deadline,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"A42AE962-14A5-48A4-A48D-A2F81CE81FB3\";\"test 22\";;\(deadlineTime);true;\(createdOnTime);\(updatedOnTime);"
        ),
        (
            TodoItem(id: "7EBC7227-0F22-4A95-BA75-9AA854A81FC5",
                     text: "test 23",
                     priority: .high,
                     deadline: deadline,
                     isDone: true,
                     createdOn: createdOn,
                     updatedOn: updatedOn),
            "\"7EBC7227-0F22-4A95-BA75-9AA854A81FC5\";\"test 23\";high;\(deadlineTime);true;\(createdOnTime);\(updatedOnTime);"
        )
    ]
}
