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
    @Published var priority: Priority
    
    @Published var calendarIsHidden = true
    @Published var isSwitchOn = false
    @Published var taskExists: Bool
    
    private var cancellables = Set<AnyCancellable>()
    private var task: TodoItem
    
    private let dataCache: FileCache
    
    init(_ currentTask: TodoItem?, with dataCache: FileCache) {
        self.taskExists = currentTask != nil
        
        self.task = currentTask ?? TodoItem(text: "", priority: .medium)
        self.dataCache = dataCache
        
        description = task.text
        deadline = task.deadline
        priority = task.priority
        
        print("task: \(task)\n")
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
    
    func setDeadline(_ date: Date? = nil) {
        if let deadlineDate = date {
            deadline = Calendar.current.date(byAdding: .day, value: 1, to: deadlineDate)
        } else {
            deadline = date
        }
    }
    
    func showDeadlineCalendar(_ isOn: Bool) {
        isSwitchOn = isOn
    }
    
    func updatePriority(priorityIndex: Int) {
        priority = Priority.getPriority(priorityIndex) ?? .medium
    }
    
    func saveTask() {
        var writtenTask: TodoItem
        if taskExists {
            writtenTask = TodoItem(id: task.id,
                                   text: description,
                                   priority: priority,
                                   deadline: deadline,
                                   isDone: task.isDone,
                                   createdOn: task.createdOn,
                                   updatedOn: Date())
        } else {
            writtenTask = TodoItem(text: description,
                                   priority: priority,
                                   deadline: deadline,
                                   createdOn: Date(),
                                   updatedOn: Date())
        }
        
        print("task: \(writtenTask)\n")
        dataCache.add(writtenTask)
        try? dataCache.save(name: "Tasks", as: .json)
        
        taskExists = true
    }
    
    func removeTask() {
        dataCache.remove(by: task.id)
        try? dataCache.save(name: "Tasks", as: .json)
    }
}
