//
//  TodoList.TableDataSource.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit

final class TodoListTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var shownTasks = [TodoItemViewModel]()
    private var headerView: TodoListTableViewHeader!
    
    init(with viewModel: TodoListViewModel) {
        super.init()
        self.headerView = TodoListTableViewHeader(with: viewModel)
        self.reload(data: viewModel.tasks)
    }
    
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
}
