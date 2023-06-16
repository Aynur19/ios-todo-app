//
//  CsvParser.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import Foundation

enum CsvSeparator: String {
    case comma = ","
    case semicolon = ";"
}

protocol CsvParser {
    associatedtype Element
    
    static func parse(csv: String) -> Element?
    
    var csv: String { get }
    
}
