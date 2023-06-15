//
//  DataCashe.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 15.06.2023.
//

import Foundation

protocol DataCache {
    associatedtype Element
    
    func add(_ task: Element)
    
    func remove(by id: String) -> Bool
    
    func save(to path: String?) -> Bool
    
    func load(from path: String?) -> Bool
}
