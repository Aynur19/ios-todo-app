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
        
        self.viewModel.$completedTasksCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] count in
                self?.updateCompletedTasksLabel(count: count)
            }
            .store(in: &cancellables)
    }
    
    private func setup() {
        self.addSubview(headerContainerView)
        
        headerContainerView.addSubview(completedTasksLabel)
        headerContainerView.addSubview(completedTasksVisibilityLabel)
        
        NSLayoutConstraint.activate([
            headerContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.mg16),
            headerContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.mg16),
//            headerContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//                .with(priority: .defaultHigh),
            headerContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins.mg8),
            headerContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins.mg12)
                .with(priority: .defaultHigh),
            
            
            completedTasksLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            completedTasksLabel.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor),
            
            completedTasksVisibilityLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            completedTasksVisibilityLabel.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor),
            
//            self.heightAnchor.constraint(equalTo: headerContainerView.heightAnchor, constant: 20),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var headerContainerView = UIView.getContainer()
//    private lazy var headerЫзфсукй = UIView.getContainer()
    
    private lazy var completedTasksLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subhead
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var completedTasksVisibilityLabel: UILabel = {
        var label = UILabel()
        label.font = Fonts.subheadBold
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let completedTasksVisibilityLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeadlineDateLabelTapped))
        label.addGestureRecognizer(completedTasksVisibilityLabelTapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    // MARK: - Intents
    @objc private func onDeadlineDateLabelTapped() {
        viewModel.changeCompletedItemsVisibility()
    }
    
    private func updateCompletedTasksLabel(count: Int) {
        completedTasksLabel.text = "Выполнено - \(count)"
    }
}
