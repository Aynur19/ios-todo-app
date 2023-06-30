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
    private var dataSource: TodoListTableDataSource!
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = TodoListTableDataSource(with: TodoListTableViewHeader(with: viewModel))
        
        setup()
        setupNavBar()
        bindViewModel()
    }
    
    // MARK: - Setup Functions
    private func setup() {
        title = Titles.todoList
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        view.addSubview(tasksTableContainer)
        NSLayoutConstraint.activate([
            tasksTableContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tasksTableContainer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -Sizes.margin_2x16),
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
        
        tasksTableView.delegate = dataSource
        tasksTableView.dataSource = dataSource
        
        tasksTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        viewModel.shownTasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tasks in
                self?.dataSource.shownTasks = tasks
                self?.tasksTableView.reloadData()
             }
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var tasksTableView = TodoListTableView(for: self.view)
    
    private lazy var tasksTableContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
}

