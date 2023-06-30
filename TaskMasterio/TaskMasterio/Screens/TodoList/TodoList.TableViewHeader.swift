//
//  TodoList.TableViewHeader.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit

private let headerLabelText = "Выполнено - "
private let showCompletedTasks = "Показать"
private let hideCompletedTasks = "Скрыть"



final class TodoListTableViewHeader: UIView {
    
    private var viewModel: TodoListViewModel!
    private var completedTasksIsHidden = true
    
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
        self.addSubview(completedTasksVisibilityLabel)
        
        NSLayoutConstraint.activate([
            completedTasksLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins._16),
            completedTasksLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins._8),
            completedTasksLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins._12),
            
            completedTasksVisibilityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins._16),
            completedTasksVisibilityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins._8),
            completedTasksVisibilityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins._12),
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
    
    private lazy var completedTasksVisibilityLabel: UILabel = {
        var label = UILabel()
        label.text = showCompletedTasks
        label.font = Fonts.getFont(named: .subheadBold)
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let completedTasksVisibilityLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeadlineDateLabelTapped))
        label.addGestureRecognizer(completedTasksVisibilityLabelTapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    @objc private func onDeadlineDateLabelTapped() {
        viewModel.changeCompletedTasksVisibility()
        completedTasksIsHidden.toggle()
        completedTasksVisibilityLabel.text = completedTasksIsHidden ? hideCompletedTasks : showCompletedTasks
    }
}
