//
//  TodoListViewModel.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 22.07.2023.
//

import Foundation
//import Combine

class TodoListViewModel: ObservableObject {
    
    private var list = [TodoItemViewModel]()
    
    @Published var withCompleted: Bool = false {
        didSet {
            filterList()
        }
    }
    
    @Published var shownList = [TodoItemViewModel]()
    @Published var completedCount: Int = 0
        
    init(todoItems: [TodoItem]) {
        for item in todoItems {
            list.append(TodoItemViewModel(todoItem: item))
        }
        
        filterList()
    }
    
    func filterList() {
        shownList = withCompleted ? list : list.filter { !$0.isDone }
        completedCount = list.filter { $0.isDone }.count
    }
}
