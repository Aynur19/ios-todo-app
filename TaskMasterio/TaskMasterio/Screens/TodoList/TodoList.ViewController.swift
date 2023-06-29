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
        setupTasksTableView()
    }
    
    // MARK: - Setup Functions
    private func setup() {
        title = "Мои дела"
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
    }
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTasksTableView() {
        view.addSubview(tasksTableView)
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    // MARK: - UI Elements
    private lazy var tasksTableView = TodoListTableView(for: self.view)
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! TodoListTableViewCell
        
        let task = viewModel.tasks[indexPath.row]
        cell.textLabel?.text = Titles.task
        cell.detailTextLabel?.text = task.description
        
        return cell
    }
}
