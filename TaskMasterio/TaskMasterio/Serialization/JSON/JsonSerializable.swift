//
//  JsonSerializable.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.07.2023.
//

import Foundation

protocol JsonSerializable {
    associatedtype Element
    
    var json: Any { get }
    
    static func parse(json: Any) -> Element?
}
