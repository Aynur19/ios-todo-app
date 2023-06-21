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
    
    func add(_ task: Element) -> Element?
    
    func remove(by id: String) -> Element?
    
    func save(name: String, to url: URL?, as format: DataFormat) throws
    
    func load(name: String, from url: URL?, as format: DataFormat) throws
}
