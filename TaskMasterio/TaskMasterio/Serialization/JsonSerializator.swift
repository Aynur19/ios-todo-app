//
//  JsonSerializator.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

protocol JsonSerializator {
    associatedtype Element: JsonSerializable
    
    static func serialize(object: Element) -> Any
    
    static func deserialize(data: Any) -> Element?
}

