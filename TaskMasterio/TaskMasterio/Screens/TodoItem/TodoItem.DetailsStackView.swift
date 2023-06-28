//
//  TodoItem.DetailsStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemDetailsStackView: UIStackView {
    
    // MARK: - Lifesycle Functions
    init() {
        super.init(frame: .zero)
        
        setupDetailsStackView()
        setupPriorityStackView()
        setupSeparator_1()
        setupDeadlineStackView()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Details Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setupDetailsStackView() {
        self.axis = .vertical
        self.alignment = .center
//        self.spacing = Sizes.margin_16
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
            separator_1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins._2x16),
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
    
    // MARK: - UI Elements
    private lazy var priorityStackView = TodoItemPriorityStackView()
    
    private lazy var deadlineStackView = TodoItemDeadlineStackView()
    
    private lazy var separator_1 = getSeparator()
    
    private func getSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIColor(named: AccentColors.supportSeparator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }
}

