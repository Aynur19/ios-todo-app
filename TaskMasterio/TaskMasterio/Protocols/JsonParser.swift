//
//  JsonParser.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import Foundation

protocol JsonParser {
    associatedtype Element
    
    var json: Any { get }
    
    static func parse(json: Any) -> Element?
}
