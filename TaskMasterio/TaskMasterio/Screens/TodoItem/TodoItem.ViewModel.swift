//
//  TodoItem.ViewModel.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import Combine
import Foundation

enum TasksStates {
    case none
    case isDone
    case highPriority
    case mediumPriority
    case lowPriority
    case close
    case remove
}

final class TodoItemViewModel: ObservableObject {
    private weak var viewModel: TodoListViewModel?
//    private let dataCache: DataCacheImp
    @Published var description: String
    @Published var deadline: Date?
    @Published var priority: Priority
    @Published var isDone: Bool
    @Published var calendarIsHidden = true
    @Published var itemExists: Bool
    @Published var taskState: TasksStates = .none
    
    private(set) var id: String
    private var cancellables = Set<AnyCancellable>()
    private var task: TodoItem
    
//    private let dataCache: FileCache

    
    init(_ currentTask: TodoItem?, viewModel: TodoListViewModel) {
        self.itemExists = currentTask != nil
//        self.dataCache = dataCache
        self.viewModel = viewModel
        
        self.task = currentTask ?? TodoItem(text: "", priority: .medium)
       
        
        description = task.text
        deadline = task.deadline
        priority = task.priority
        isDone = task.isDone
        id = task.id
        
        updateState()
    }
    
    func updateState() {
        if isDone { taskState = .isDone }
        else {
            switch priority {
            case .low: taskState = .lowPriority
            case .medium: taskState = .mediumPriority
            case .high: taskState = .highPriority
            }
        }
        
        
    }
    
    func mergeItems() -> TodoItem {
        var mergedItem: TodoItem
        if itemExists {
            mergedItem = TodoItem(id: task.id, text: description, priority: priority, deadline: deadline,
                                  isDone: isDone, createdOn: task.createdOn, updatedOn: Date())
        } else {
            mergedItem = TodoItem(text: description, priority: priority, deadline: deadline, createdOn: Date(), updatedOn: Date())
        }
        
        return mergedItem
    }
    
    func updateInDataCache() {
//        _ = dataCache.add(mergeItems())
    }
    
    var taskIsChanged: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(descriptionIsChanged, priorityIsChanged, deadlineIsChanged)
            .map { $0 || $1 || $2 }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsChanged: AnyPublisher<Bool, Never> {
        return $description
            .map { $0 != self.task.text }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsNotEmpty: AnyPublisher<Bool, Never> {
        
        return $description
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var priorityIsChanged: AnyPublisher<Bool, Never> {
        return $priority
            .map { $0 != self.task.priority }
            .eraseToAnyPublisher()
    }
    
    var deadlineIsChanged: AnyPublisher<Bool, Never> {
        return $deadline
            .map { $0?.datetime != self.task.deadline?.datetime }
            .eraseToAnyPublisher()
    }
    
    var deadlineStr: AnyPublisher<String?, Never> {
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
        calendarIsHidden = isOn
    }
    
    func updatePriority(priorityIndex: Int) {
        priority = Priority.getPriority(priorityIndex) ?? .medium
    }
    
    func changeItemCompletion() {
        isDone.toggle()
        save()
//        viewModel?.changeItemCompletion(by: id)
    }
    
//    func changeTaskCompletion() {
//        isDone.toggle()
//        updateState()
//        saveTask()
//    }
    
//    func getTask() -> TodoItem {
//        var writtenTask: TodoItem
//        if itemExists {
//            writtenTask = TodoItem(id: task.id,
//                                   text: description,
//                                   priority: priority,
//                                   deadline: deadline,
//                                   isDone: task.isDone,
//                                   createdOn: task.createdOn,
//                                   updatedOn: Date())
//        } else {
//            writtenTask = TodoItem(text: description,
//                                   priority: priority,
//                                   deadline: deadline,
//                                   createdOn: Date(),
//                                   updatedOn: Date())
//        }
//
//        return writtenTask
//    }
    
    func save() {
        let savedItem = mergeItems()
        print("Сохранение элемента: \(savedItem)")
        viewModel?.addTask(item: savedItem)
//        print("task: \(writtenTask)\n")
//        dataCache.add(writtenTask)
//        try? dataCache.save(name: "Tasks", as: .json)
        
        itemExists = true
    }
    
    func remove() {
        viewModel?.removeItem(by: id)
    }
    
    
//    func removeTask() -> TodoItem? {
//        return dataCache.remove(by: task.id)
////        try? dataCache.save(name: "Tasks", as: .json)
//    }
}
