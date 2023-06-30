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
    }
    
    var completedTasksCount: Int {
        tasks
            .filter { $0.isDone }
            .count
    }
    
    
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
