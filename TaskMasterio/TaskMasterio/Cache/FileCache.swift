//
//  FileCache.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation

final class FileCache {
    private(set) var tasks = [TodoItem]()
    
    func clearTasks() { tasks.removeAll() }
}

extension FileCache: DataCache {
    
    func add(_ task: TodoItem) -> TodoItem? {
        var result: TodoItem? = nil
        if let idx = tasks.firstIndex(where: { $0.id == task.id }) {
            result = tasks[idx]
            tasks[idx] = task
        } else {
            tasks.append(task)
        }
        
        return result
    }
    
    func remove(by id: String) -> TodoItem? {
        guard let idx = tasks.firstIndex(where: { $0.id == id }) else { return nil }
        return tasks.remove(at: idx)
    }
    
    // MARK: - Save Data
    func save(name: String, to url: URL? = nil, as format: DataFormat) throws {
        switch format {
        case .json:
            try saveToJson(name: name, to: url)
        case .csv:
            try saveToCsv(name: name, to: url)
        }
    }
    
    func saveToJson(name: String, to url: URL? = nil) throws {
        let tasksJson = tasks.map({ $0.json })
        var jsonData: Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: tasksJson, options: .prettyPrinted)
        } catch {
            throw FileCacheError.jsonSerializationFailed(error: error)
        }
        
        let fileURL = try getFileURL(name: name, url: url, as: DataFormat.json.rawValue)
        do{
            try jsonData.write(to: fileURL)
        } catch {
            throw FileCacheError.jsonWritingToFileFailed(path: fileURL.path, error: error)
        }
    }
    
    func saveToCsv(name: String, to url: URL? = nil) throws {
        let tasksCsv = getTasksCsv()
        let fileURL = try getFileURL(name: name, url: url, as: DataFormat.csv.rawValue)
        
        do {
            try tasksCsv.write(toFile: fileURL.path, atomically: true, encoding: .utf8)
        } catch {
            throw FileCacheError.csvWritingToFileFailed(path: fileURL.path, error: error)
        }
    }
    
    private func getTasksCsv() -> String {
        let headers = TodoItem.getHeaders().appending(CsvSeparator.newLine.rawValue)
        let data = tasks.map({ $0.csv.appending(CsvSeparator.newLine.rawValue) })
        
        return headers + data.joined()
    }
    
    // MARK: - Load Data
    func load(name: String, from url: URL?, as format: DataFormat) throws {
        switch format {
        case .json:
            try loadFromJson(name: name, to: url)
        case .csv:
            try loadFromCsv(name: name, from: url)
        }
    }
    
    func loadFromJson(name: String, to url: URL?) throws {
        let jsonURL = try getFileURL(name: name, url: url, as: DataFormat.json.rawValue, forSaving: false)
        
        var jsonData: Data
        do {
            jsonData = try Data(contentsOf: jsonURL)
        } catch {
            throw FileCacheError.jsonReadingFromFileFailed(path: jsonURL.path, error: error)
        }
        
        var parsingErrorsCount = 0
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            
            guard let tasksFromJson = jsonObject as? [[String: Any]] else {
                throw FileCacheError.castingToDictionaryFailed
            }
            
            clearTasks()
            for task in tasksFromJson  {
                if let parsedTask = TodoItem.parse(json: task) {
                    if add(parsedTask) == nil { continue }
                }
                
                parsingErrorsCount += 1
            }
        } catch let dataCacheError as FileCacheError {
            throw dataCacheError
        } catch {
            throw FileCacheError.jsonDeserializationFailed(error: error)
        }
        
        if parsingErrorsCount > 0 {
            throw FileCacheError.jsonObjectParsingFailed(path: jsonURL.path, count: parsingErrorsCount)
        }
    }
    
    func loadFromCsv(name: String, from url: URL?) throws {
        let csvURL = try getFileURL(name: name, url: url, as: DataFormat.csv.rawValue, forSaving: false)
        
        var csvData: String
        do {
            csvData = try String(contentsOf: csvURL, encoding: .utf8)
        } catch {
            throw FileCacheError.csvReadingFromFileFailed(path: csvURL.path, error: error)
        }
        
        let rows = csvData.split(separator: Character(CsvSeparator.newLine.rawValue)).map({ String($0) })
        if rows.isEmpty { return }
        
        let startRow = rows[0] == TodoItem.getHeaders() ? 1 : 0
        var parsingErrorsCount = 0
        clearTasks()
        
        for row in rows[startRow...] {
            if let parsedTask = TodoItem.parse(csv: row) {
                if add(parsedTask) == nil { continue }
            }
            
            parsingErrorsCount += 1
        }
        
        if parsingErrorsCount > 0 {
            throw FileCacheError.csvObjectParsingFailed(path: csvURL.path, count: parsingErrorsCount)
        }
    }
    
    private func getFileURL(name: String, url: URL?, as format: String, forSaving: Bool = true) throws -> URL {
        let fileManager = FileManager.default
        guard var fileURL = url ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileCacheError.notPassedDataURL
        }
        
        if forSaving {
            if !fileManager.fileExists(atPath: fileURL.path) {
                do {
                    try fileManager.createDirectory(atPath: fileURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                }
                catch { throw FileCacheError.folderCreatingFailed(path: fileURL.path, error: error) }
            }
        }
        
        fileURL.appendPathComponent(name)
        fileURL.appendPathExtension(format)
        
        if !forSaving {
            guard fileManager.fileExists(atPath: fileURL.path) else {
                throw FileCacheError.notExistsFile(path: fileURL.path)
            }
        }
        
        return fileURL
    }
}
