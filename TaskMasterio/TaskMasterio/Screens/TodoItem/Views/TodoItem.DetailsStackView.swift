//
//  TodoItem.DetailsStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit
import Combine

final class TodoItemDetailsStackView: UIStackView {
    
    private var viewModel: TodoItemViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
        
        setupPriorityStackView()
        setupSeparator_1()
        setupDeadlineStackView()
        setupSeparator_2()
        setupDeadlineDatePicker()
        
        bindViewModel()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Details Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.axis = .vertical
        self.alignment = .center
        self.backgroundColor = UIColor(named: AccentColors.backSecondary)
        self.layer.cornerRadius = Sizes.cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPriorityStackView() {
        self.addArrangedSubview(priorityStackView)
        
        NSLayoutConstraint.activate([
            priorityStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    private func setupSeparator_1() {
        self.addArrangedSubview(separator_1)
        
        NSLayoutConstraint.activate([
            separator_1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins.mg32),
            separator_1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separator_1.heightAnchor.constraint(equalToConstant: Sizes.separatorH),
        ])
    }
    
    private func setupDeadlineStackView() {
        self.addArrangedSubview(deadlineStackView)
        
        NSLayoutConstraint.activate([
            deadlineStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    private func setupSeparator_2() {
        self.addArrangedSubview(separator_2)
        
        NSLayoutConstraint.activate([
            separator_2.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins.mg32),
            separator_2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separator_2.heightAnchor.constraint(equalToConstant: Sizes.separatorH),
        ])
    }
    
    private func setupDeadlineDatePicker() {
        self.addArrangedSubview(deadlineDatePicker)
        
        NSLayoutConstraint.activate([
            deadlineDatePicker.widthAnchor.constraint(equalTo: self.widthAnchor),
            deadlineDatePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$calendarIsHidden
            .assign(to: \.isHidden, on: separator_2)
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var priorityStackView = TodoItemPriorityStackView(with: viewModel)
    
    private lazy var separator_1 = getSeparator()
    
    private lazy var deadlineStackView = TodoItemDeadlineStackView(with: viewModel)
    
    private lazy var separator_2 = getSeparator()
    
    private lazy var deadlineDatePicker = TodoItemDeadlineDatePickerView(with: viewModel)
    
    private func getSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIColor(named: AccentColors.supportSeparator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }
}

