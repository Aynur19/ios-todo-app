//
//  TodoList.TableView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListTableView: UITableView {
    
    // MARK: - Lifesycle Functions
    init(for view: UIView) {
        super.init(frame: view.bounds, style: .insetGrouped)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.register(TodoListTableViewCell.self, forCellReuseIdentifier: Titles.todoListCellId)
        self.backgroundColor = UIColor(named: AccentColors.backPrimary)
        self.layer.cornerRadius = Sizes.cornerRadius
//        self.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
