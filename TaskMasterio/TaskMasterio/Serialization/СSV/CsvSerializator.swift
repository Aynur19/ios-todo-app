//
//  CsvSerializator.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

protocol CsvSerializator {
    associatedtype Element: CsvSerializable
    
    static var csvSeparator: CsvSeparator { get set }
    
    static func serialize(object: Element) -> String
    
    static func deserialize(data: String) -> Element?
}

extension CsvSerializator {
    static var csvSeparator: CsvSeparator {
        get { return .semicolon }
        set { csvSeparator = newValue }
    }
}
