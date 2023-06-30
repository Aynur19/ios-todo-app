//
//  TodoList.TableViewHeader.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit

private let headerLabelText = "Выполнено - "

final class TodoListTableViewHeader: UIView {
    
    private var viewModel: TodoListViewModel!
    
    init(with viewModel: TodoListViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize TodoListTableViewHeader...")
    }
    
    private func setup() {
        self.addSubview(completedTasksLabel)
        
        NSLayoutConstraint.activate([
            completedTasksLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins._16),
            completedTasksLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins._8),
            completedTasksLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins._12)
        ])
    }
    
    private lazy var completedTasksLabel: UILabel = {
        let label = UILabel()
        label.text = headerLabelText + String(viewModel.completedTasksCount)
        label.font = Fonts.getFont(named: .subhead)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
