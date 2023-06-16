//
//  FileCache.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation

class FileCache {
    private(set) var tasks = [TodoItem]()
    private let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func clear() {
        tasks.removeAll()
    }
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
    
    func saveToJson(name: String, to directoryUrl: URL?) -> Bool {
        print("Serialization tasks to DATA...")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: tasksData, options: .prettyPrinted)
        else { return false }

        print("Serialization DATA to String (JSON)...")
        guard let json = String(data: jsonData, encoding: .utf8) else { return false }
        
        var result = false
        do {
            print("Getting filepath...")
            var fileURL = directoryUrl ?? self.fileUrl
            fileURL.append(path: "\(name).json")
            
            print("Writing JSON to FILE: \(fileURL.path()) ...")
            try json.write(toFile: fileURL.path(), atomically: true, encoding: .utf8)
            
            result = true
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func loadFromJson(name: String, to url: URL?) -> Int {
        var errorsCount = 0
        
        let jsonUrl = url ?? fileUrl.appending(path: "\(name).json")
        guard let jsonData = try? Data(contentsOf: jsonUrl),
              let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
              let tasks = jsonObject as? [[String: Any]]
        else { return -1 }
        
        clear()
        for task in tasks {
            if let taskFromJson = TodoItem.parse(json: task) {
                if !add(taskFromJson) {
                    errorsCount += 1
                }
            } else {
                errorsCount += 1
            }
        }
        
        return errorsCount
    }
    
    func saveToCsv(name: String, to directoryUrl: URL?) -> Bool {
        print("Serialization tasks to DATA...")
        var data = TodoItem.getHeaders().appending("\n")
        
        for task in tasks {
            data += task.csv.appending("\n")
        }
        
        var result = false
        do {
            print("Getting filepath...")
            var fileURL = directoryUrl ?? self.fileUrl
            fileURL.append(path: "\(name).csv")
            
            print("Writing JSON to FILE: \(fileURL.path()) ...")
            try data.write(toFile: fileURL.path(), atomically: true, encoding: .utf8)
            
            result = true
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func loadFromCsv(name: String, from url: URL?) -> Int {
        var errorsCount = 0
        
        let jsonUrl = url ?? fileUrl.appending(path: "\(name).json")
        guard let jsonData = try? Data(contentsOf: jsonUrl),
              let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
              let tasks = jsonObject as? [[String: Any]]
        else { return -1 }
        
        clear()
        for task in tasks {
            if let taskFromJson = TodoItem.parse(json: task) {
                if !add(taskFromJson) {
                    errorsCount += 1
                }
            } else {
                errorsCount += 1
            }
        }
        
        return errorsCount
    }
    
    
    func load(from path: String?) -> Bool {
        return false
    }
    
    private var tasksData: [Any] {
        var tasksList = [Any]()

        for task in tasks {
            tasksList.append(task.json)
        }
        
        return tasksList
    }
}
