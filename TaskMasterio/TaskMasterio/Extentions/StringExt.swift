//
//  StringExt.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import Foundation

extension String {
    func quote() -> String {
        let escapedString = self.replacingOccurrences(of: "\"", with: "\"\"")
        return "\"\(escapedString)\""
    }
}
