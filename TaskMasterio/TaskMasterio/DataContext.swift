//
//  DataContext.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 14.07.2023.
//

import Foundation

final class DataContext {
    var todoLists: [TodoList]
//    var todoItems: [TodoItem]
    
    init() {
        self.todoLists = [TodoList]()
//        self.todoItems = [TodoItem]()
    }
}
