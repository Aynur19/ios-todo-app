//
//  TodoList.TableViewHeader.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit
import Combine


final class TodoListTableViewHeader: UIView {
    
    // MARK: - Properties
    private var viewModel: TodoListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoListViewModel) {
        super.init(frame: .zero)
        
        setup()
        bindViewModel(viewModel)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize TodoListTableViewHeader...")
    }
    
    // MARK: - Setup Functions
    private func bindViewModel(_ viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        self.viewModel.showTasksButtonLabel
            .assign(to: \.text, on: completedTasksVisibilityLabel)
            .store(in: &cancellables)
        
        self.viewModel.completedTasksCountLabel
            .assign(to: \.text, on: completedTasksLabel)
            .store(in: &cancellables)
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
    
    // MARK: - UI Elements
    private lazy var completedTasksLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(named: .subhead)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var completedTasksVisibilityLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.getFont(named: .subheadBold)
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let completedTasksVisibilityLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeadlineDateLabelTapped))
        label.addGestureRecognizer(completedTasksVisibilityLabelTapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    // MARK: - Intents
    @objc private func onDeadlineDateLabelTapped() {
        viewModel.changeCompletedTasksVisibility()
    }
}
