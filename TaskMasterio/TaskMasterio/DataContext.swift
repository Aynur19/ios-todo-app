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
//    var todoItems: [TodoItem]
    
//    init() {
//        self.context = [Entity]()
////        self.todoItems = [TodoItem]()
//    }
}

//class BaseDataContext<T: StringIdentifiable>: DataContext {
//    typealias Entity = T
//    var context: [Entity]
//
////    static var shared = BaseDataContext<T>()
//
//    private init() {
//        context = [Entity]()
//    }
//}
//
//final class TodoListContext: BaseDataContext<TodoList> {
//    static let shared = TodoListContext()
//
//    override init() {
//
//    }
//}
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
//    var todoItems: [TodoItem]
    
//    init() {
//        self.context = [Entity]()
////        self.todoItems = [TodoItem]()
//    }
//}
