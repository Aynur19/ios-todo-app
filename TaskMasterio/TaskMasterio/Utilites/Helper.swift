//
//  Helper.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 13.07.2023.
//

import Foundation

final class Helper {
    static func checkAndCreateDirectory(url: URL) throws {
        try checkAndCreateDirectory(path: getPathFromUrl(url))
    }
    
    static func checkAndCreateDirectory(path: String) throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw FileCacheError.folderCreatingFailed(path: path, error: error)
            }
        }
    }
    
    static func getPathFromUrl(_ url: URL) -> String {
        if #available(iOS 16.0, *) {
            return url.path()
        } else {
            return url.path
        }
    }
    
    static func stringToDate(dateStr: String, dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        guard let date = dateFormatter.date(from: dateStr) else { return nil }
        return date
    }
}
