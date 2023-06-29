//
//  TodoItem.RemoveButton.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit
import Combine

final class TodoItemRemoveButton: UIButton {
    
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
        fatalError("Trying to initialize Todo Item Remove Button...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.setTitle(Titles.delete, for: .normal)
        self.backgroundColor = UIColor(named: AccentColors.backSecondary)
        self.setTitleColor(UIColor(named: AccentColors.colorRed), for: .normal)
        self.setTitleColor(UIColor(named: AccentColors.labelTertiary), for: .disabled)
        self.layer.cornerRadius = Sizes.cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func bindViewModel() {
        viewModel.taskIsChanged
            .assign(to: \.isEnabled, on: self)
            .store(in: &cancellables)
    }
}
