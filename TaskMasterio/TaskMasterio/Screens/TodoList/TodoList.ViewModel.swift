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
private let filename = "TodoList"

final class TodoListViewModel: ObservableObject {
    private let networkService: NetworkService
    private var dataCache: DataCacheImp
    private var cancellables = Set<AnyCancellable>()
    
    @Published var shownItems = [TodoItemViewModel]()
    @Published var completedTasksCount = 0
    @Published var completedIsHidden = true
    
    init(with dataCache: DataCacheImp, networkService: NetworkService) {
        self.dataCache = dataCache
        self.networkService = networkService
        
        //        loadDataFromFileSystem()
        loadDataFromNetwork()
        saveOnFileSystem()
        //        dataSynchronization()
        //        loadItem(id: tasks[0].id)
    }
    
    private func loadDataFromFileSystem(name: String = "TodoList", format: DataFormat = .json) {
        Task {
            do {
                print("ЗАГРУЗКА ДАННЫХ ИЗ ФАЙЛОВОЙ СИСТЕМЫ...")
                try dataCache.load(name: name, as: format)
//                print(dataCache.dataStore)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadDataFromNetwork() {
        Task {
            do {
                print("ЗАГРУЗКА ДАННЫХ С СЕРВЕРА...")
                let result = await self.networkService.getList()
                switch result {
                case .success(let list):
                    let items = try TodoItemMapper.mapToTodoList(from: list)
                    dataCache.clearItems()
                    for item in items {
                        dataCache.add(item)
                    }
                    updateMetadata(revision: list.revision, isDirty: false)
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
    
    private func dataSynchronization() {
        let list = dataCache.dataStore.items.map { TodoItemNetworkDto(todoItem: $0) }
        let requestBody = TodoListRequest(list: list)
        
        Task {
            print("СИНХРОНИЗАЦИЯ ДАННЫХ...")
            let result = await self.networkService.patchList(with: requestBody)
            switch result {
            case .success(let list):
                print("  list: \(list)")
            case .failure(let error):
                print("  error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchItem(id: String) {
        Task {
            print("ЗАПРОС НА ПОЛУЧЕНИЕ ЭЛЕМЕНТА ПО ID: \(id)...")
            let result = await self.networkService.getItem(id: id)
            switch result {
            case .success(let list):
                print("  list: \(list)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func postAddItem(id: String) {
        Task {
            print("ЗАПРОС НА ДОБАВЛЕНИЕ ЭЛЕМЕНТА...")
            do {
                guard let item = dataCache.dataStore.items.first(where: { $0.id == id }) else { return }
                let requestBody = TodoItemRequest(element: TodoItemNetworkDto(todoItem: item))
                print("Добавление элемента на сервер...")
                
                let result = await self.networkService.postItem(with: requestBody, revision: dataCache.dataStore.revision)
                switch result {
                case .success(let element):
                    let items = try TodoItemMapper.mapToTodoItem(from: element.item)
                    print("Success result: \(element)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    private func putAddItem(id: String) {
        Task {
            print("ЗАПРОС НА ИЗМЕНЕНИЕ ЭЛЕМЕНТА...")
            do {
                guard let item = dataCache.dataStore.items.first(where: { $0.id == id }) else { return }
                let requestBody = TodoItemRequest(element: TodoItemNetworkDto(todoItem: item))
                print("Изменение элемента на сервере...")
                
                let result = await self.networkService.putItem(with: requestBody, revision: dataCache.dataStore.revision)
                switch result {
                case .success(let element):
                    updateMetadata(revision: element.revision, isDirty: false)
                    print("Success result: \(element)")
                case .failure(let error):
                    print(error.localizedDescription)
//                    updateMetadata(revision: element.revision, isDirty: true)
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteItem(item: TodoItem) {
        Task {
            print("ЗАПРОС НА УДАЛЕНИЕ ЭЛЕМЕНТА...")
            do {
                let requestBody = TodoItemRequest(element: TodoItemNetworkDto(todoItem: item))
                print("Изменение элемента на сервере...")
                
                let result = await self.networkService.deleteItem(with: requestBody, revision: dataCache.dataStore.revision)
                switch result {
                case .success(let element):
                    updateMetadata(revision: element.revision, isDirty: false)
                    print("Success result: \(element)")
                case .failure(let error):
                    print(error.localizedDescription)
//                    updateMetadata(revision: element.revision, isDirty: true)
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateMetadata(revision: Int, isDirty: Bool) {
        dataCache.updateMetadata(revision:  revision, isDirty: isDirty)
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
        
        completedTasksCount = dataCache.dataStore.items.filter { $0.isDone }.count
    }
    
    func changeCompletedItemsVisibility() {
        //                loadDataFromNetwork()
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
        if let _ = dataCache.add(item) {
            putAddItem(id: item.id)
        } else {
            postAddItem(id: item.id)
        }
        
        refreshData()
        
        print("Добавлен элемент: \(item)")
    }
    
    func removeItem(by id: String?) {
        guard let itemId = id else { return }
        
        
        if let removedItem = dataCache.remove(by: itemId) {
            deleteItem(item: removedItem)
            print("Удален элемент: \(removedItem)")
            refreshData()
        }
    }
    
    func saveOnFileSystem() {
        Task {
            do {
                try dataCache.save(name: filename)
                print("Данные успешно сохранены!")
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
}
