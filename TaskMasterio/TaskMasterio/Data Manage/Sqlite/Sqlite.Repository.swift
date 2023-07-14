//
//  Sqlite.Repository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import SQLite

protocol SqliteRepository {
    var inserts: [Insert] { get }
    var updates: [Update] { get }
    var deletes: [Delete] { get }
    
    func clearInserts()
    func clearUpdates()
    func clearDeletes()
}
