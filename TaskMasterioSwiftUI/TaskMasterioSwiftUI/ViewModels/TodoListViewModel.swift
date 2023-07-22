//
//  TodoListViewModel.swift
//  TaskMasterioSwiftUI
//
//  Created by Aynur Nasybullin on 22.07.2023.
//

import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    
    private var list = [TodoItemViewModel]()
    
    @Published var withCompleted: Bool = false {
        didSet {
            filterList()
        }
    }
    
    @Published var shownList = [TodoItemViewModel]()
    @Published var completedCount: Int = 0 {
        didSet {
            filterList()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
        
    init(todoItems: [TodoItem]) {
        list = todoItems.map { TodoItemViewModel(todoItem: $0) }
        
        list.forEach({ itemVM in
            itemVM.$isDone
                .sink { [weak self] isDone in
                    
                    if isDone {
                        self?.completedCount += 1
                    } else {
                        self?.completedCount -= 1
                    }
                }
                .store(in: &cancellables)
        })
        
        completedCount = list.filter { $0.isDone }.count
    }
    
    func filterList() {
        shownList = withCompleted ? list : list.filter { !$0.isDone }
    }
}
