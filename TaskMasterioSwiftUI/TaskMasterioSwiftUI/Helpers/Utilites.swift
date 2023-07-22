//
//  Utilites.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 22.07.2023.
//

import Foundation

class Utilites {
    
    static func date(from date: String, as format: String) -> Date? {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date)
    }
}
