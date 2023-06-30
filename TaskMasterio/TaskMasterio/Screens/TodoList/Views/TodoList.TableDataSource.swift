//
//  TodoList.TableDataSource.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit

final class TodoListTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var shownTasks = [TodoItemViewModel]()
    private var headerView: TodoListTableViewHeader!
    
    init(with headerView: TodoListTableViewHeader) {
        super.init()
        self.headerView = headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Titles.todoListCellId, for: indexPath) as! TodoListTableViewCell
        cell.bindViewModel(with: shownTasks[indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
