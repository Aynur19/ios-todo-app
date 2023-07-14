//
//  DataStore.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 13.07.2023.
//

import Foundation

protocol DataStore {
    var name: String { get }
    var connectionUrl: URL? { get }
    
    func configure(name: String, connectionUrl: URL?)
    
    func load() -> Result<Void, Error>
    func save() -> Result<Void, Error>
}
