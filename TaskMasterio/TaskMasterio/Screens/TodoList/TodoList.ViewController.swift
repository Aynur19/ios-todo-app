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
    //    private var dataSource: TodoListTableDataSource!
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        dataSource = TodoListTableDataSource(with: viewModel)
        
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
        
        viewModel.$shownTasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tasks in
                self?.reload(data: tasks)
                self?.tasksTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var newTaskButton: UIButton = {
        let button = UIButton()
        let normalImage = UIImage(named: "Add Task")
        button.setImage(normalImage, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc private func buttonTapped() {
        let detailViewController = TodoItemViewController2()
        detailViewController.viewModel = TodoItemViewModel(TodoItem(text: "", priority: .medium), with: viewModel.dataCache)
        detailViewController.todoListVM = viewModel
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
        let detailViewController = TodoItemViewController2()
        detailViewController.viewModel = todoItemViewModel
        
        present(detailViewController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Titles.todoListCellId, for: indexPath) as! TodoListTableViewCell
        cell.bindViewModel(with: shownTasks[indexPath.row])
        cell.tag = indexPath.row
        print("task index: \(indexPath.row)")
        
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
            self?.viewModel.changeTaskCompletion(by: self?.shownTasks[indexPath.row].id)
            completion(true)
        }
        
        deleteAction.backgroundColor = UIColor(named: "Color Green") ?? .green
        deleteAction.image = UIImage(systemName: "checkmark.circle.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completion) in
            self?.viewModel.removeTask(by: self?.shownTasks[indexPath.row].id)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = shownTasks[indexPath.row]
        
        let detailViewController = TodoItemViewController2()
        detailViewController.viewModel = selectedItem
        detailViewController.todoListVM = viewModel
        let todoItemNavigationController = UINavigationController(rootViewController: detailViewController)
        present(todoItemNavigationController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoListViewController: TodoListViewModelDelegate {
    func addViewModelToList() {
        viewModel.updateTodoList()
    }
}
