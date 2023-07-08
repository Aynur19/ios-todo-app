//
//  Configuration.Helper.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 07.07.2023.
//

import Foundation

struct Configuration {
    static func getSharedValue(for key: String) -> String? {
        return getValue(from: "SharedConfigs", for: key)
    }
    
    static func getPrivateValue(for key: String) -> String? {
        return getValue(from: "PrivateConfigs", for: key)
    }
    
    private static func getValue(from filename: String, for key: String) -> String? {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "plist"),
              let plistData = try? Data(contentsOf: fileURL),
              let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any]
        else {
            return nil
        }
        
        return plist[key] as? String
    }
}
