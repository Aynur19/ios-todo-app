//
//  CsvSerializable.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

protocol CsvSerializable {
    associatedtype Element
    
    var csv: String { get }
    
    static func parse(csv: String) -> Element?
}
