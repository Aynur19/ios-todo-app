//
//  FileCache.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation

class FileCache {
    private(set) var tasks: [TodoItem] = [TodoItem]()
}
 
extension FileCache: DataCache {
    
    func add(_ task: TodoItem) -> Bool {
        if let idx = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[idx] = task
            return false
        }
        
        tasks.append(task)
        return true
    }
    
    func remove(by id: String) -> Bool {
        guard let idx = tasks.firstIndex(where: { $0.id == id }) else { return false }
        _ = tasks.remove(at: idx)
        return true
    }
    
    func save(to path: String?) -> Bool {
        return false
    }
    
    func saveToJson(name: String, to path: String?) -> Bool {
        var tasksList = [Any]()
        
        for task in tasks {
            tasksList.append(task.json)
        }
        
        print("Serialization tasks to DATA...")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: tasksList) else { return false }

        print("Serialization DATA to JSON...")
        guard let json = String(data: jsonData, encoding: .utf8) else { return false }
        
        var result = false
        do {
            print("Getting URL for filepath...")
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first!.appendingPathComponent("\(name).json")
            
            print("Writing JSON to FILE...")
            try json.write(to: fileURL, atomically: true, encoding: .utf8)
            
            result = true
        } catch {
            print("ERROR \(error.localizedDescription)")
        }
        
        return result
    }
    
    func load(from path: String?) -> Bool {
        return false
    }
}
