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
        self.spacing = Sizes.margin_16
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
    
    private func setupDeadlineStackView() {
        self.addArrangedSubview(deadlineStackView)
        
        NSLayoutConstraint.activate([
            deadlineStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var priorityStackView = TodoItemPriorityStackView()
    
    private lazy var deadlineStackView = TodoItemDeadlineStackView()
}

