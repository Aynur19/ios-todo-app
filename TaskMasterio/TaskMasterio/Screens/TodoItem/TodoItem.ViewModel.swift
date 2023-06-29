//
//  TodoItem.ViewModel.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import Combine
import Foundation


final class TodoItemViewModel: ObservableObject {
    
    @Published var description: String
    @Published var deadline: Date?
    @Published var priority: Priority?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var task: TodoItem
    
    init(currentTask: TodoItem) {
        self.task = currentTask
        
        description = task.text
        deadline = task.deadline
        priority = task.priority
    }
    
    var taskIsChanged: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(descriptionIsChanged, priorityIsChanged, deadlineIsChanged)
            .map { $0 || $1 || $2 }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsChanged: AnyPublisher<Bool, Never> {
        print("description: \(description) \nself.task.text: \(self.task.text)")
        return $description
            .map { $0 != self.task.text }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsNotEmpty: AnyPublisher<Bool, Never> {
        print("descriptionIsEmpty: \(description.isEmpty)")
        
        return $description
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var priorityIsChanged: AnyPublisher<Bool, Never> {
        $priority
            .map { $0 != self.task.priority }
            .eraseToAnyPublisher()
    }
    
    var deadlineIsChanged: AnyPublisher<Bool, Never> {
        $deadline
            .map { $0?.datetime != self.task.deadline?.datetime }
            .eraseToAnyPublisher()
    }
}
