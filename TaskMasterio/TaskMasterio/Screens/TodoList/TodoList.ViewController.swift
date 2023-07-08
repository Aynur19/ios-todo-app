//
//  TodoList.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit
import Combine


final class TodoListViewController: UIViewController {
    
    var viewModel: TodoListViewModel!
    private var shownTasks = [TodoItemViewModel]()
    private var headerView: TodoListTableViewHeader!
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavBar()
        bindViewModel()
    }
    
    // MARK: - Setup Functions
    private func setup() {
        title = Titles.todoList
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        self.headerView = TodoListTableViewHeader(with: self.viewModel)
        view.addSubview(tasksTableContainer)
        NSLayoutConstraint.activate([
            tasksTableContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tasksTableContainer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tasksTableContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksTableContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        setupTasksTableView(for: tasksTableContainer)
    }
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTasksTableView(for owner: UIView) {
        owner.addSubview(tasksTableView)
        
        NSLayoutConstraint.activate([
            tasksTableView.centerXAnchor.constraint(equalTo: owner.centerXAnchor),
            tasksTableView.widthAnchor.constraint(equalTo: owner.widthAnchor),
            tasksTableView.topAnchor.constraint(equalTo: owner.topAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: owner.bottomAnchor),
        ])
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        tasksTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(newTaskButton)
        view.bringSubviewToFront(newTaskButton)
        NSLayoutConstraint.activate([
            newTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -54),
            newTaskButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            newTaskButton.widthAnchor.constraint(equalToConstant: 44),
            newTaskButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func bindViewModel() {
        
        viewModel.$shownItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.reload(data: items)
                self?.tasksTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var newTaskButton: UIButton = {
        let button = UIButton()
        let normalImage = UIImage(named: "Add Task")
        button.setImage(normalImage, for: .normal)
        button.addTarget(self, action: #selector(onNewItemButtonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc private func onNewItemButtonTapped() {
        let viewModel = TodoItemViewModel(TodoItem(text: "", priority: .medium), viewModel: viewModel)
        let detailViewController = TodoItemViewController(viewModel: viewModel)
        let todoItemNavigationController = UINavigationController(rootViewController: detailViewController)
        
        present(todoItemNavigationController, animated: true, completion: nil)
    }
    
    private lazy var tasksTableView = TodoListTableView(for: self.view)
    
    private lazy var tasksTableContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private func present(with todoItemViewModel: TodoItemViewModel) {
        let detailViewController = TodoItemViewController(viewModel: todoItemViewModel)
        
        present(detailViewController, animated: true, completion: nil)
    }
    
    // MARK: For URLSession.performTask(...) testing
    struct Model: Codable {
        var setup: String
        var punchline: String
        var id: Int
    }
    
    private var task: Task<Void, Never>?
    private var jokes = [String]()
    private var jokeId = 0
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Телефон был потрясен!")
            performTask()
        }
    }
    
    private func performTask() {
        task?.cancel()
        task = Task { [weak self] in
            do {
                self?.jokeId += 1
                let urlStr = "https://official-joke-api.appspot.com/jokes/\(jokeId)"
                let sleepingInterval = UInt64.random(in: 1000000000...3000000000)
                print("url: \(urlStr) \n    sleepeng interval: \(sleepingInterval / 1000000000)")
                try await Task.sleep(nanoseconds: sleepingInterval)
                let urlSession = URLSession.shared
                guard let url = URL(string: urlStr) else {
                    throw URLSessionError.failedTaskPerformingError(error: URLSessionError.failedCreationURL(str: urlStr))
                }
                
                let urlRequest = URLRequest(url: url)
                let result = try await urlSession.performTask(for: urlRequest)
                
                let data = result.data
                let model = try JSONDecoder().decode(Model.self, from: data)
                
                let joke = "Joke #\(model.id): \(model.setup) \(model.punchline)"
                self?.jokes.append(joke)
                print(joke)
            } catch {
                print("Ошибка: \(error)")
            }
        }
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func reload(data: [TodoItemViewModel]) {
        shownTasks.removeAll(keepingCapacity: true)
        shownTasks.append(contentsOf: data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Titles.todoListCellId, for: indexPath) as? TodoListTableViewCell
        else { return UITableViewCell() }
        
        cell.bindViewModel(with: shownTasks[indexPath.row])
        cell.tag = indexPath.row
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self]  (action, view, completion) in
            self?.viewModel.changeItemCompletion(by: self?.shownTasks[indexPath.row].id)
            completion(true)
        }
        
        deleteAction.backgroundColor = UIColor(named: "Color Green") ?? .green
        deleteAction.image = UIImage(systemName: "checkmark.circle.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completion) in
            self?.viewModel.removeItem(by: self?.shownTasks[indexPath.row].id)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = shownTasks[indexPath.row]
        let detailViewController = TodoItemViewController(viewModel: selectedItem)
        let todoItemNavigationController = UINavigationController(rootViewController: detailViewController)
        
        present(todoItemNavigationController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
