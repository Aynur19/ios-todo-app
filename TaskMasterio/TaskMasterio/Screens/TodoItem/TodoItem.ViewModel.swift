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
    
    @Published var calendarIsHidden = true
    @Published var isSwitchOn = false
    
    private var cancellables = Set<AnyCancellable>()
    private var task: TodoItem
    
    init(currentTask: TodoItem) {
        self.task = currentTask
        
        description = task.text
        deadline = task.deadline
        priority = task.priority
        
        $isSwitchOn
            .map { return self.getDefaultDeadline(isOn: $0) }
            .assign(to: &$deadline)

        print("description: \(description)")
        print("deadline: \(deadline)")
        print("priority: \(priority)")
        print("calendarIsHidden: \(calendarIsHidden)")
    }
    
    var taskIsChanged: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(descriptionIsChanged, priorityIsChanged, deadlineIsChanged)
            .map { $0 || $1 || $2 }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsChanged: AnyPublisher<Bool, Never> {
        print("descriptionIsChanged: \(description != self.task.text)")
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
        print("priorityIsChanged: \(priority != self.task.priority)")
        return $priority
            .map { $0 != self.task.priority }
            .eraseToAnyPublisher()
    }
    
    var deadlineIsChanged: AnyPublisher<Bool, Never> {
        print("descriptionIsEmpty: \(description.isEmpty)")
        return $deadline
            .map { $0?.datetime != self.task.deadline?.datetime }
            .eraseToAnyPublisher()
    }
    
    var deadlineStr: AnyPublisher<String?, Never> {
        print("deadlineStr: \(deadline?.toString())")
        return $deadline
            .map { $0?.toString() }
            .eraseToAnyPublisher()
    }
    
    private func getDefaultDeadline(isOn: Bool) -> Date? {
        let deadlineDate = isOn ? Calendar.current.date(byAdding: .day, value: 1, to: Date()) : nil
        print("deadlineDate \(deadlineDate)")
        return deadlineDate
    }
}
