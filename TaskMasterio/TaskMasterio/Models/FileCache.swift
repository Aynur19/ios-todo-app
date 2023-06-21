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
    
    func clear() { tasks.removeAll() }
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
    
    // MARK: - Save Data
    func save(name: String, to directoryUrl: URL?, as format: DataFormat) -> Bool {
        switch format {
        case .json: return saveToJson(name: name, to: directoryUrl)
        case .csv: return saveToJson(name: name, to: directoryUrl)
        default: return saveToJson(name: name, to: directoryUrl)
        }
    }
    
    func saveToJson(name: String, to directoryUrl: URL?) -> Bool {
        print("Serialization tasks to DATA...")
        guard let jsonData = try? JSONSerialization.data(withJSONObject: tasksData, options: .prettyPrinted)
        else { return false }
        
        print("Getting String (JSON) from DATA...")
        guard let json = String(data: jsonData, encoding: .utf8) else { return false }
        
        var result = false
        do {
            let fileManager = FileManager.default
            
            print("Getting filepath...")
            var fileURL = directoryUrl ?? self.fileUrl
            
            if !fileManager.fileExists(atPath: fileURL.path()) {
                try fileManager.createDirectory(atPath: fileURL.path(), withIntermediateDirectories: true, attributes: nil)
            }
            fileURL.append(path: "\(name).\(DataFormat.json.rawValue)")
            
            print("Writing JSON to FILE (.json): \(fileURL.path()) ...")
            try json.write(toFile: fileURL.path(), atomically: true, encoding: .utf8)
            
            result = true
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func saveToCsv(name: String, to directoryUrl: URL?) -> Bool {
        let lineSeparator = "\n"
        var data = TodoItem.getHeaders().appending(lineSeparator)
        
        for task in tasks {
            data += task.csv.appending(lineSeparator)
        }
        
        var result = false
        do {
            print("Getting filepath...")
            var fileURL = directoryUrl ?? self.fileUrl
            
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: fileURL.path()) {
                try fileManager.createDirectory(atPath: fileURL.path(), withIntermediateDirectories: true, attributes: nil)
            }
            fileURL.append(path: "\(name).\(DataFormat.csv.rawValue)")
            
            print("Writing JSON to FILE (.csv): \(fileURL.path()) ...")
            try data.write(toFile: fileURL.path(), atomically: true, encoding: .utf8)
            
            result = true
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        return result
    }
    
    // MARK: - Load Data
    func load(name: String, from directoryUrl: URL?, as format: DataFormat) -> Int {
        switch format {
        case .json: return loadFromJson(name: name, to: directoryUrl)
        case .csv: return loadFromCsv(name: name, from: directoryUrl)
        default: return loadFromJson(name: name, to: directoryUrl)
        }
    }
    
    func loadFromJson(name: String, to directoryUrl: URL?) -> Int {
        var errorsCount = 0
        var jsonUrl = directoryUrl ?? self.fileUrl
        jsonUrl.append(path: "\(name).\(DataFormat.json.rawValue)")
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: jsonUrl.path()) { return -1 }
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            guard let tasks = jsonObject as? [[String: Any]] else { return -1 }
            
            clear()
            for task in tasks {
                if let taskFromJson = TodoItem.parse(json: task) {
                    if !add(taskFromJson) {
                        errorsCount += 1
                    }
                } else { errorsCount += 1 }
            }
        } catch {
            print("ERROR: \(error.localizedDescription)")
            errorsCount = -1
        }
        
        return errorsCount
    }
    
    func loadFromCsv(name: String, from url: URL?) -> Int {
        let lineSeparator = "\n"
        var errorsCount = 0
        var csvUrl = url ?? fileUrl
        csvUrl.append(path: "\(name).\(DataFormat.csv.rawValue)")
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: csvUrl.path()) { return -1 }
        
        clear()
        
        do {
            let csv = try String(contentsOf: csvUrl, encoding: .utf8)
            let rows = csv.split(separator: lineSeparator).map({ String($0) })
            
            if rows.isEmpty { return 0 }
            
            let startRow = rows[0] == TodoItem.getHeaders() ? 1 : 0
            
            for row in rows[startRow...] {
                if let task = TodoItem.parse(csv: row) {
                    errorsCount += add(task) ? 0 : 1
                }
                else { errorsCount += 1 }
            }
        } catch {
            print("ERROR: \(error.localizedDescription)")
            errorsCount = -1
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
