//
//  DataCashe.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation

enum DataFormat: String {
    case json
    case csv
}

protocol DataCache {
    associatedtype Element
    
    func add(_ task: Element) -> Bool
    
    func remove(by id: String) -> Bool
    
    func save(name: String, to directoryUrl: URL?, as format: DataFormat) -> Bool
    
    func load(name: String, from directoryUrl: URL?, as format: DataFormat) -> Int
}
