//
//  TodoList.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListViewController: UIViewController {
    
    var viewModel: TodoListViewModel!
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavBar()
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
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    // MARK: - UI Elements
    private lazy var tasksTableView = TodoListTableView(for: self.view)
    
    private lazy var tasksTableContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Titles.todoListCellId, for: indexPath) as! TodoListTableViewCell
        
        let task = viewModel.tasks[indexPath.row]
        cell.textLabel?.text = Titles.task
        cell.detailTextLabel?.text = task.description
        
        return cell
    }
    
}
