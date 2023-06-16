//
//  TodoItem.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 11.06.2023.
//

import Foundation

enum Priority: String {
    case high
    case medium
    case low
}

struct TodoItem {
    static let idLenght = 36
    
    let id: String
    let text: String
    let priority: Priority
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let updatedOn: Date?
    
    init(id: String = UUID().uuidString, text: String, priority: Priority, deadline: Date?, isDone: Bool,
         createdOn: Date, updatedOn: Date?) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.updatedOn = updatedOn
    }
    
    enum CodingKeys: String {
        case id
        case text
        case priority
        case deadline
        case isDone
        case createdOn
        case updatedOn
    }
}

extension TodoItem {
    static func getId(data: String?) -> String? {
        guard let idData = data, idData.count == idLenght else { return nil }
        return idData
    }
    
    static func getPriority(data: String?) -> Priority? {
        if let priorityData = data, !priorityData.isEmpty {
            guard let priorityValue = Priority.init(rawValue: priorityData) else { return nil }
            return priorityValue
        }
        
        return .medium
    }
    
    static func getDate(data: String?, isOptional: Bool = false) -> (isValid: Bool, result: Date?) {
        guard let dateData = data else { return (true, nil) }
        if dateData.isEmpty { return (true, nil) }
        
        guard let dateTime = Int(dateData) else { return (false, nil) }
        return (true, Date(timeIntervalSince1970: TimeInterval(dateTime)))
    }
    
    static func getBool(data: String?) -> Bool? {
        guard let boolData = data else { return nil }
        
        if boolData == "\(false)" { return false }
        else if boolData == "\(true)" { return true }
        
        return nil
    }
}

extension TodoItem {
    var json: Any {
        var data = [String: Any]()
        data["id"] = id
        data["text"] = text
        
        if priority != .medium {
            data["priority"] = "\(priority)"
        }
        
        if let jsonDeadline = deadline {
            data["deadline"] = Int(jsonDeadline.timeIntervalSince1970)
        }
        
        data["isDone"] = isDone
        data["createdOn"] = Int(createdOn.timeIntervalSince1970)
        
        if let jsonUpdatedOn = updatedOn {
            data["updatedOn"] = Int(jsonUpdatedOn.timeIntervalSince1970)
        } else {
            data["updatedOn"] = nil
        }
        
        return data
    }
    
    static func parse(json: Any) -> TodoItem? {
        guard let dict = json as? [String: Any] else { return nil }
        
        guard let id = dict["id"] as? String,
              let text = dict["text"] as? String,
              let createdOn = (dict["createdOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        else { return nil }
        
        var priority: Priority
        if dict["priority"] != nil {
            guard let priorityValue = (dict["priority"] as? String).flatMap({ Priority.init(rawValue: $0) })
            else { return nil }
            
            priority = priorityValue
        } else {
            priority = Priority.medium
        }
        
        let deadline = (dict["deadline"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        if dict["deadline"] != nil, deadline == nil { return nil }
        
        guard let isDone = (dict["isDone"] as? Bool) else { return nil }
        
        let updatedOn = (dict["updatedOn"] as? Int).flatMap({ Date(timeIntervalSince1970: TimeInterval($0)) })
        if dict["updatedOn"] != nil, updatedOn == nil { return nil }
        
        return TodoItem(id: id, text: text, priority: priority, deadline: deadline, isDone: isDone,
                        createdOn: createdOn, updatedOn: updatedOn)
    }
}

extension TodoItem: CsvParser {
    static func parse(csv: String) -> TodoItem? {
        //"\"DC0419AE-8DF7-4847-863D-FB2D67F8DDD8\";\"test 1; test 1.2, 1.3|4;\";;;false;\(createdOnTime);;"
        
        guard !csv.isEmpty else { return nil }
        
        let fieldsStr: [String?] = csv.split(separator: "\"", omittingEmptySubsequences: false).map({ String($0) })
        
        guard fieldsStr.count >= 5,
              let idCsv = getId(data: fieldsStr[1]),
              let textCsv = fieldsStr[3]
        else { return nil }
        
        guard let fieldsDiff = fieldsStr.last??.split(separator: ";", omittingEmptySubsequences: false).map({ String($0) }),
              fieldsDiff.count > 5
        else { return nil }
        
        guard let priorityCsv = getPriority(data: fieldsDiff[1]) else { return nil }
        
        let deadlineCsv = getDate(data: fieldsDiff[2])
        guard deadlineCsv.isValid else { return nil }
        
        guard let isDoneCsv = getBool(data: fieldsDiff[3]) else { return nil }
              
        let createdOnCsv = getDate(data: fieldsDiff[4])
        guard createdOnCsv.isValid, let createdOnResult = createdOnCsv.result else { return nil }
        
        let updatedOnCsv = getDate(data: fieldsDiff[5])
        guard updatedOnCsv.isValid else { return nil }
        
        return TodoItem.Element(id: idCsv, text: textCsv, priority: priorityCsv, deadline: deadlineCsv.result,
                                isDone: isDoneCsv, createdOn: createdOnResult, updatedOn: updatedOnCsv.result)
        //        if fields[1].count != idLenght { return nil }
        //
        //        guard let fieldsDiff = fields.last?.split(separator: ";", omittingEmptySubsequences: false )
        //            .map({ String($0) })
        //        else { return nil }
        //
        //        guard let priorityCsv = getPriority(data: fieldsDiff[1]) else { return nil }
        ////        if fieldsDiff[1].isEmpty {
        //            priorityCsv = .medium
        //        } else {
        //            guard let priorityValue = Priority.init(rawValue: fieldsDiff[1]) { return nil }
        //            priorityCsv = priorityValue
        //        }
        
        //        var dedlianeCsv: Date?
        //        if fieldsDiff[2].isEmpty {
        //            priorityCsv = nil
        //        } else {
        //
        //        }
        
        //        guard let isDoneCsv = getPriority(data: fieldsDiff[3]) else { return nil }
        //        if fieldsDiff[3].isEmpty {
        //            priorityCsv = .medium
        //        } else {
        //
        //        }
        
        //        var isDoneCsv: Bool
        //        if fieldsDiff[4].isEmpty {
        //            priorityCsv = .medium
        //        } else {
        //
        //        }
        //        var isDoneCsv: Bool
        //        if fieldsDiff[5].isEmpty {
        //            priorityCsv = .medium
        //        } else {
        //
        //        }
        //
        
//        return nil
    }
    
    var csv: String {
        var fields = [String]()
        fields.append(id.quote())
        fields.append(text.quote())
        
        if priority != .medium {
            fields.append("\(priority)")
        } else {
            fields.append("")
        }
        
        if let deadlineTime = deadline?.datetime {
            fields.append("\(deadlineTime)")
        } else {
            fields.append("")
        }
        
        fields.append("\(isDone)")
        fields.append("\(createdOn.datetime)")
        
        if let updatedOnTime = updatedOn?.datetime {
            fields.append("\(updatedOnTime)")
        } else {
            fields.append("")
        }
        
        return fields.joined(separator: ";").appending(";")
    }
}
