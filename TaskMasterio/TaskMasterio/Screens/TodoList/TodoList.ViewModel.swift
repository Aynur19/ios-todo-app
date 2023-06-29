//
//  TodoList.ViewModel.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import Foundation
import Combine

final class TodoListViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    var tasks = [TodoItemViewModel]()
    
    private let dataCache: FileCache
    
    init(with dataCache: FileCache) {
        self.dataCache = dataCache
        
        loadData()
    }
    
    private func loadData() {
        try? dataCache.load(name: "Tasks", as: .json)
        
        for _ in 1...5 {
            tasks.append(TodoItemViewModel(dataCache.tasks.first, with: dataCache))
        }
    }
}
