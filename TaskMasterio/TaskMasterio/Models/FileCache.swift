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
    func add(_ task: TodoItem) {
        if let idx = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[idx] = task
        } else {
            tasks.append(task)
        }
    }
    
    func remove(by id: String) -> Bool {
        guard let idx = tasks.firstIndex(where: { $0.id == id }) else { return false }
        _ = tasks.remove(at: idx)
        return true
    }
    
    func save(to path: String?) -> Bool {
        return false
    }
    
    func load(from path: String?) -> Bool {
        return false
    }
}
