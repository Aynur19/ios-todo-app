//
//  Repository.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

protocol Repository {
    associatedtype Entity: StringIdentifiable

    var dataset: [DataContext] { get }
    
    func get(by id: String) -> Entity?
    func getAll() -> [Entity]
    func insert(_ entity: Entity) -> Entity?
    func update(_ entity: Entity) -> Entity?
    func upsert(_ entity: Entity) -> Entity?
    func delete(by id: String) -> Entity?
}

//protocol SqliteRepository: Repository {
//    associatedtype Entity: StringIdentifiable
//
//    var context: [DataContext] { get }
//    
//    func get(by id: String) -> Entity?
//    func getAll() -> [Entity]
//    func insert(_ entity: Entity) -> Entity?
//    func update(_ entity: Entity) -> Entity?
//    func upsert(_ entity: Entity) -> Entity?
//    func delete(by id: String) -> Entity?
//}
