//
//  DataContext.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation
import CoreData

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



protocol CoreDataContext {
    associatedtype Object: NSManagedObject
    var context: [Object] { get set }
}

final class TodoListCoreDataContext: CoreDataContext {
    typealias Object = TodoListManagedObject
    var context: [Object]

    static let shared = TodoListCoreDataContext()

    private init() {
        context = [Object]()
    }
}

final class TodoItemCoreDataContext: CoreDataContext {
    typealias Object = TodoItemManagedObject
    var context: [Object]
    
    static let shared = TodoItemCoreDataContext()
    
    private init() {
        context = [Object]()
    }
}
