//
//  TodoItem.PriorityStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import UIKit

final class TodoItemPriorityStackView: UIStackView {
    
    // MARK: - Lifesycle Functions
    init() {
        super.init(frame: .zero)
        
        setupPriorityStackView()
        setupPriorityLabel()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Priority Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setupPriorityStackView() {
        self.axis = .horizontal
        self.spacing = Sizes.margin_16
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPriorityLabel() {
        self.addArrangedSubview(priorityLabel)
        
        NSLayoutConstraint.activate([
            priorityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = Titles.priority
        label.font = Fonts.getFont(named: .body)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
