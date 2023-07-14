//
//  DataContext.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

protocol DataContext {
    associatedtype Entity: StringIdentifiable
    var context: [Entity] { get set }
}

final class TodoListContext: DataContext {
    typealias Entity = TodoList
    var context: [Entity]

    static let shared = TodoListContext()

    private init() {
        context = [Entity]()
    }
}

final class TodoItemContext: DataContext {
    typealias Entity = TodoItem
    var context: [Entity]
    
    static let shared = TodoItemContext()
    
    private init() {
        context = [Entity]()
    }
}
