////
////  TodoList.OldViewController.swift
////  TaskMasterio
////
////  Created by Aynur Nasybullin on 08.07.2023.
////
//
//import Foundation
//import Combine
//
//private let completedTasksCountStr = "Выполнено - "
//private let showCompletedTasksStr = "Показать"
//private let hideCompletedTasksStr = "Скрыть"
//
//
//protocol TodoListViewModelDelegate: AnyObject {
//    func addViewModelToList()
//}
//
//final class TodoListOldViewModel: ObservableObject {
//    private let networkService: NetworkService
////    private let dataCache: any DataCache
//
//    @MainActor
//    private var loadTask: Task<Void, Never>?
//    weak var delegate: TodoListViewModelDelegate?
//    private(set) var tasks = [TodoItemViewModel]()
//    private var cancellables = Set<AnyCancellable>()
//
//    //    var cancellationSource: Task.CancellationSource?
//
//    @Published var completedTasksCount = 0
//    @Published var completedTasksIsHidden = true
//
//    @Published var shownTasks = [TodoItemViewModel]()
//
//    let dataCache: FileCache
//
//    init(with dataCache: FileCache, networkService: NetworkService) {
//        self.dataCache = dataCache
//        self.networkService = networkService
//
//        loadDataFromFS()
//        loadDataFromNetwork()
//        //        dataSynchronization()
//        loadItem(id: tasks[0].id)
//    }
//
//    private func loadDataFromFS(name: String = "TodoItems", format: DataFormat = .json) {
//        Task {
//            do {
//                print("Loading data rom File System...")
//                try dataCache.load(name: name, as: format)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    private func loadDataFromNetwork() {
//        Task {
//            print("Loading data from Network...")
//            let result = await self.networkService.getList()
//            switch result {
//            case .success(let list):
//                print("Success result: \(list)")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    private func dataSynchronization() {
//        let list = tasks.map { TodoItemNetworkDto(todoItem: $0.getTask()) }
//        let requestBody = TodoListRequest(list: list)
//
//        Task {
//            print("PATCH TASK STARTED...")
//            let result = await self.networkService.patchList(with: requestBody)
//            switch result {
//            case .success(let list):
//                print("  list: \(list)")
//            case .failure(let error):
//                print("  error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    private func loadItem(id: String) {
//        Task {
//            print("GET ITEM TASK STARTED...")
//            let result = await self.networkService.getItem(id: id)
//            switch result {
//            case .success(let list):
//                print("  list: \(list)")
//            case .failure(let error):
//                print("  error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func changeCompletedTasksVisibility() {
//        loadDataFromNetwork()
//        completedTasksIsHidden.toggle()
//        updateTodoList()
//    }
//
//    var showTasksButtonLabel: AnyPublisher<String?, Never> {
//        return $completedTasksIsHidden
//            .map { $0 ? showCompletedTasksStr : hideCompletedTasksStr }
//            .eraseToAnyPublisher()
//    }
//
//    var completedTasksCountLabel: AnyPublisher<String?, Never> {
//        return $completedTasksCount
//            .map { completedTasksCountStr + String($0) }
//            .eraseToAnyPublisher()
//    }
//
//    func updateTodoList() {
//        if completedTasksIsHidden {
//            shownTasks = tasks.filter { !$0.isDone }
//        } else {
//            shownTasks = tasks
//        }
//
//        completedTasksCount = tasks.filter { $0.isDone }.count
//    }
//
//    func changeTaskCompletion(by id: String?) {
//        guard let taskId = id else { return }
//
//        if let task = tasks.first { $0.id == taskId } {
//            task.isDone.toggle()
//            task.updateState()
//        }
//        updateTodoList()
//    }
//
//
//    func present(by id: String?) {
//        guard let taskId = id else { return }
//
//    }
//
//
//
//    private func loadData() {
//        //        try? dataCache.load(name: "TodoItems", as: .json)
//        //
//        //        if dataCache.tasks.isEmpty {
//        ////            var newTasks = generateTasks()
//        ////            for task in newTasks {
//        ////                dataCache.add(task)
//        ////            }
//        //        }
//
////        for task in dataCache.tasks {
////            tasks.append(TodoItemViewModel(task, with: dataCache))
////        }
//
//        updateTodoList()
//    }
//
//    func addTask(todo: TodoItem) {
//        dataCache.add(todo)
//
//        tasks.removeAll()
//        for task in dataCache.tasks {
//            tasks.append(TodoItemViewModel(task, with: dataCache))
//        }
//
//        updateTodoList()
//    }
//
//    func removeTask(by id: String?) {
//        guard let taskId = id else { return }
//        print("id: \(taskId)")
//
//        if let idx = tasks.firstIndex(where: { $0.id == taskId }) {
//            tasks.remove(at: idx)
//            dataCache.remove(by: taskId)
//        }
//
//        updateTodoList()
//    }
//
//
//    //    private func generateTasks() -> [TodoItem] {
//    //        var tasks = [TodoItem]()
//    //
//    //        tasks.append(
//    //            TodoItem(text: "Позвонить",
//    //                     priority: .low))
//    //        tasks.append(
//    //            TodoItem(text: "Подготовить презентацию для клиента",
//    //                     priority: .medium,
//    //                     isDone: true))
//    //        tasks.append(
//    //            TodoItem(text: "Провести анализ рынка и подготовить отчет с рекомендациями",
//    //                     priority: .high,
//    //                     deadline: Date()))
//    //        tasks.append(
//    //            TodoItem(text: "Разработать стратегию маркетинговой кампании, включающую целевую аудиторию, каналы продвижения и бюджет",
//    //                     priority: .low,
//    //                     isDone: true))
//    //        tasks.append(
//    //            TodoItem(text: "Организовать тренинг для сотрудников по повышению навыков коммуникации и эффективного управления временем",
//    //                     priority: .medium))
//    //        tasks.append(TodoItem(text: "Отправить письмо",
//    //                              priority: .low))
//    //        tasks.append(
//    //            TodoItem(text: "Организовать встречу с партнерами",
//    //                     priority: .high,
//    //                     deadline: Date(),
//    //                     isDone: true
//    //                    ))
//    //        tasks.append(
//    //            TodoItem(text: "Согласовать бюджет проекта с финансовым отделом и утвердить его",
//    //                     priority: .low))
//    //        tasks.append(
//    //            TodoItem(text: "Провести тестирование нового программного обеспечения и составить детальный отчет о найденных ошибках и рекомендациях по исправлению",
//    //                     priority: .medium,
//    //                     isDone: true))
//    //        tasks.append(
//    //            TodoItem(text: "Провести аудит информационной безопасности компании и разработать план по устранению выявленных уязвимостей и рисков",
//    //                     priority: .high,
//    //                     deadline: Date()))
//    //
//    //        return tasks
//    //    }
//}
