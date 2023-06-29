//
//  TodoItem.DeadlineDatePickerView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit
import Combine

final class TodoItemDeadlineDatePickerView: UIDatePicker {
    
    private var viewModel: TodoItemViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
        bindViewModel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Deadline Date Picker View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.datePickerMode = .date
        self.preferredDatePickerStyle = .inline
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(deadlineValueChanged(_:)), for: .valueChanged)
    }
    
    private func bindViewModel() {
        viewModel.$calendarIsHidden
            .assign(to: \.isHidden, on: self)
            .store(in: &cancellables)
    }
    
    @objc func deadlineValueChanged(_ sender: UIDatePicker) {
        viewModel.deadline = sender.date
    }
}
