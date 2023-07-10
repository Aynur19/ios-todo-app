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
    case newLine = "\n"
}

protocol CsvParser {
    associatedtype Element
    
    static var csvSeparator: CsvSeparator { get set }
    
    static func parse(csv: String) -> Element?
    
    var csv: String { get }
}
