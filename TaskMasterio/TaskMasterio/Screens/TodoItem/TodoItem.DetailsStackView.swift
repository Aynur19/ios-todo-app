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
        
        
        self.addArrangedSubview(priorityStackView)
    }
    
    // MARK: - UI Elements
    private lazy var priorityStackView = TodoItemPriorityStackView()
}

