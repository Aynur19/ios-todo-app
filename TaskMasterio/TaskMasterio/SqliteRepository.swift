//
//  SqliteRepository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

//import Foundation
import SQLite

protocol SqliteRepository {
    var inserts: [Insert] { get }
    var updates: [Update] { get }
    var deletes: [Delete] { get }
    
    func clearInserts()
    
    func clearUpdates()
    
    func clearDeletes()
//    func load() -> Swift.Result<Void, Error>
//    func save() -> Swift.Result<Void, Error>
}
