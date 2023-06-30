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
    private var viewModel: TodoListViewModel!
    
    init(with viewModel: TodoListViewModel) {
        super.init()
        self.viewModel = viewModel
        self.headerView = TodoListTableViewHeader(with: self.viewModel)
        self.reload(data: self.viewModel.tasks)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        } else {
            return UITableView.automaticDimension
        }
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//            // Perform deletion logic for the corresponding cell at the indexPath
//            completion(true)
//        }
//
//        // You can customize the appearance of the action, such as background color and image
//        deleteAction.backgroundColor = .red
//        deleteAction.image = UIImage(named: "DeleteIcon")
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Perform deletion logic for the corresponding item in your view model
////            viewModel.deleteItem(at: indexPath.row)
////            // Update the table view after deleting the item
////            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completion) in
            // Perform deletion logic for the corresponding cell at the indexPath
            self?.viewModel.removeTask(by: self?.shownTasks[indexPath.row].id)
            completion(true)
        }

        // Set the image for the delete action
        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
