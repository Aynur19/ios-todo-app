//
//  TodoList.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListViewController: UIViewController {
    
    var viewModel: TodoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavBar()
        setupTasksTableView()
    }
    
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
    }
    
    private var tasksTableView: UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        return tableView
    }
}

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! TodoListTableViewCell
        
        let task = viewModel.tasks[indexPath.row]
        // Configure the cell with the data from the view model
        cell.textLabel?.text = Titles.task
        cell.detailTextLabel?.text = task.description
        // Update other cell UI elements based on the view model data
        
        return cell
    }
}
