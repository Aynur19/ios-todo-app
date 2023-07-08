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
    private let networkService: NetworkService
    private var dataCache: DataCacheImp
    private var cancellables = Set<AnyCancellable>()
    
    @Published var shownItems = [TodoItemViewModel]()
    @Published var completedTasksCount = 0
    @Published var completedIsHidden = true
    
//    @MainActor
//    private var loadTask: Task<Void, Never>?
//    weak var delegate: TodoListViewModelDelegate?
//    private(set) var tasks = [TodoItemViewModel]()
    
    
    init(with dataCache: DataCacheImp, networkService: NetworkService) {
        self.dataCache = dataCache
        self.networkService = networkService
        
//        loadDataFromFS()
        loadDataFromNetwork()
        //        dataSynchronization()
//        loadItem(id: tasks[0].id)
    }
    
    private func loadDataFromFS(name: String = "TodoList", format: DataFormat = .json) {
        Task {
            do {
                print("Загрузка данных из файловой системы...")
                try dataCache.load(name: name, as: format)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadDataFromNetwork() {
        Task {
            do {
                print("Загрузка данных по сети...")
                let result = await self.networkService.getList()
                switch result {
                case .success(let list):
                    let items = try TodoItemMapper.mapToTodoList(from: list)
                    dataCache.clearItems()
                    for item in items {
                        dataCache.add(item)
                    }
                    refreshData()
                    print("Success result: \(list)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
//    private func dataSynchronization() {
//        let list = dataCache.dataStore.items.map { TodoItemNetworkDto(todoItem: $0.getTask()) }
//        let requestBody = TodoListRequest(list: list)
//
//        Task {
//            print("Начало синхронизции данных...")
//            let result = await self.networkService.patchList(with: requestBody)
//            switch result {
//            case .success(let list):
//                print("  list: \(list)")
//            case .failure(let error):
//                print("  error: \(error.localizedDescription)")
//            }
//        }
//    }
    
    private func fetchItem(id: String) {
        Task {
            print("Получение данных одного элемента по id: \(id)...")
            let result = await self.networkService.getItem(id: id)
            switch result {
            case .success(let list):
                print("  list: \(list)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func refreshData() {
        var filteredItems: [TodoItem]
        if completedIsHidden {
            filteredItems = dataCache.dataStore.items.filter { !$0.isDone }
        } else {
            filteredItems = dataCache.dataStore.items
        }
        
        shownItems.removeAll()
        shownItems.append(contentsOf: filteredItems.map { TodoItemViewModel($0, viewModel: self) })
        
        completedTasksCount = dataCache.dataStore.items.count - shownItems.count
    }
    
    func changeCompletedItemsVisibility() {
//        loadDataFromNetwork()
        completedIsHidden.toggle()
        refreshData()
    }
    
    func changeItemCompletion(by id: String?) {
        print("Изменение завершенности задачи: \(id)")
        guard let itemId = id else { return }
        
        if let shownItem = shownItems.first { $0.id == itemId } {
            shownItem.changeItemCompletion()
        }
    }
    
    var showTasksButtonLabel: AnyPublisher<String?, Never> {
        return $completedIsHidden.map { $0 ? showCompletedTasksStr : hideCompletedTasksStr }.eraseToAnyPublisher()
    }
    
    func addTask(item: TodoItem) {
        _ = dataCache.add(item)
        refreshData()
        
        print("Добавлен элемент: \(item)")
    }
    
    func removeItem(by id: String?) {
        guard let itemId = id else { return }
        
        if let removedItem = dataCache.remove(by: itemId) {
            print("Удален элемент: \(removedItem)")
            refreshData()
        }
    }
}
