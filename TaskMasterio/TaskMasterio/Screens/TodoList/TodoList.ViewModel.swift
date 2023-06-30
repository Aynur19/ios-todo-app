//
//  TodoList.ViewModel.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import Foundation
import Combine

private let completedTasksCountStr = "Выполнено - "
private let showCompletedTasksStr = "Показать"
private let hideCompletedTasksStr = "Скрыть"


final class TodoListViewModel: ObservableObject {
    
    private(set) var tasks = [TodoItemViewModel]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var completedTasksCount = 0
    @Published var completedTasksIsHidden = true
    
    private let dataCache: FileCache
    
    init(with dataCache: FileCache) {
        self.dataCache = dataCache
        
        loadData()
    }
    
    func changeCompletedTasksVisibility() {
        completedTasksIsHidden.toggle()
        
        print(shownTasks)
    }
    
    var shownTasks: AnyPublisher<[TodoItemViewModel], Never> {
        return $completedTasksIsHidden
            .map { isHidden in
                if isHidden {
                    return self.tasks.filter { !$0.isDone }
                }
                return self.tasks
            }
            .eraseToAnyPublisher()
    }
    
    var showTasksButtonLabel: AnyPublisher<String?, Never> {
        return $completedTasksIsHidden
            .map { $0 ? showCompletedTasksStr : hideCompletedTasksStr }
            .eraseToAnyPublisher()
    }
    
    var completedTasksCountLabel: AnyPublisher<String?, Never> {
        return $completedTasksCount
            .map { completedTasksCountStr + String($0) }
            .eraseToAnyPublisher()
    }
    
    private func loadData() {
        try? dataCache.load(name: "Tasks 2", as: .json)
        
        if dataCache.tasks.isEmpty {
            var newTasks = generateTasks()
            for task in newTasks {
                dataCache.add(task)
            }
        }
        
        for task in dataCache.tasks {
            tasks.append(TodoItemViewModel(task, with: dataCache))
        }
        
        refreshList()
    }

    func refreshList() {
        completedTasksCount = tasks.filter { $0.isDone }.count
    }
    
//    var completedTasksCount: Int {
//        tasks
//
//    }
    
    
    private func generateTasks() -> [TodoItem] {
        var tasks = [TodoItem]()
        
        tasks.append(
            TodoItem(text: "Позвонить",
                     priority: .low))
        tasks.append(
            TodoItem(text: "Подготовить презентацию для клиента",
                     priority: .low,
                     isDone: true))
        tasks.append(
            TodoItem(text: "Провести анализ рынка и подготовить отчет с рекомендациями",
                     priority: .low))
        tasks.append(
            TodoItem(text: "Разработать стратегию маркетинговой кампании, включающую целевую аудиторию, каналы продвижения и бюджет",
                     priority: .low,
                     isDone: true))
        tasks.append(
            TodoItem(text: "Организовать тренинг для сотрудников по повышению навыков коммуникации и эффективного управления временем",
                     priority: .low))
        tasks.append(TodoItem(text: "Отправить письмо",
                              priority: .low))
        tasks.append(
            TodoItem(text: "Организовать встречу с партнерами",
                     priority: .low,
                     isDone: true))
        tasks.append(
            TodoItem(text: "Согласовать бюджет проекта с финансовым отделом и утвердить его",
                     priority: .low))
        tasks.append(
            TodoItem(text: "Провести тестирование нового программного обеспечения и составить детальный отчет о найденных ошибках и рекомендациях по исправлению",
                     priority: .low,
                     isDone: true))
        tasks.append(
            TodoItem(text: "Провести аудит информационной безопасности компании и разработать план по устранению выявленных уязвимостей и рисков",
                     priority: .low))
        
        return tasks
    }
}
