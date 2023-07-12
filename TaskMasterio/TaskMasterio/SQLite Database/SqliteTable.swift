//
//  SqliteTable.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 12.07.2023.
//

import SQLite

protocol SqliteTable {
    static func getName() -> String
    static func createTable(dbConnection: Connection?) throws
}
