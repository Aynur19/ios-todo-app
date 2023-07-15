//
//  UnitOfWork.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation
import SQLite

protocol UnitOfWork: DataStore {
    associatedtype TodoListRepoType: TodoListRepository
    associatedtype TodoItemRepoType: TodoItemRepository
    
    var todoListRepo: TodoListRepoType { get }
    var todoItemRepo: TodoItemRepoType { get }
    
    var name: String { get }
    var connectionUrl: URL? { get }
    
    func configure(name: String, connectionUrl: URL?)
    
    func load(with primaryKey: String?) -> Swift.Result<Void, Error>
    func save() -> Swift.Result<Void, Error>
}
