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
    
    @Published var description: String
    @Published var deadline: Date?
    @Published var priority: TodoItemPriority
    @Published var isDone: Bool
    @Published var calendarIsHidden = true
//    @Published var itemExists: Bool
    @Published var taskState: TasksStates = .none
    
    private(set) var id: String
    private var cancellables = Set<AnyCancellable>()
    private var todoItem: TodoItem
    
    init(_ currentTask: TodoItem, viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        self.todoItem = currentTask
       
        description = todoItem.text
        deadline = todoItem.deadline
        priority = todoItem.priority
        isDone = todoItem.isDone
        id = todoItem.id
        
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
    
    func mergeItems(with foreignKey: String) -> TodoItem {
        let mergedItem = TodoItem(id: todoItem.id, text: description, priority: priority, deadline: deadline,
                                  isDone: isDone, createdOn: todoItem.createdOn, updatedOn: Date(), todoListId: foreignKey)
        return mergedItem
    }
    
    var taskIsChanged: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(descriptionIsChanged, priorityIsChanged, deadlineIsChanged)
            .map { $0 || $1 || $2 }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsChanged: AnyPublisher<Bool, Never> {
        return $description
            .map { $0 != self.todoItem.text }
            .eraseToAnyPublisher()
    }
    
    var descriptionIsNotEmpty: AnyPublisher<Bool, Never> {
        
        return $description
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var priorityIsChanged: AnyPublisher<Bool, Never> {
        return $priority
            .map { $0 != self.todoItem.priority }
            .eraseToAnyPublisher()
    }
    
    var deadlineIsChanged: AnyPublisher<Bool, Never> {
        return $deadline
            .map { $0?.datetime != self.todoItem.deadline?.datetime }
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
        priority = TodoItemPriority.getPriority(priorityIndex) ?? .medium
    }
    
    func changeItemCompletion() {
        isDone.toggle()
        save()
    }
    
    func save() {
        guard let foreignkey = viewModel?.currentTodoList.id else { return }
        let savedItem = mergeItems(with: foreignkey)
    
        viewModel?.updateTodoItem(item: savedItem)
        viewModel?.saveDataToDevice()
    }
    
    func remove() {
        viewModel?.deleteTodoItem(by: id)
        save()
    }
}
