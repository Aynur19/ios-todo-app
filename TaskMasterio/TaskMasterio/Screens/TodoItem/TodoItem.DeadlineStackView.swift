//
//  TodoItem.DeadlineStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import UIKit

final class TodoItemDeadlineStackView: UIStackView {
    
    // MARK: - Lifesycle Functions
    init() {
        super.init(frame: .zero)
        
        setupDeadlineStackView()
        setupDeadlineSwitcher()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Deadline Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setupDeadlineStackView() {
        self.axis = .horizontal
        self.spacing = Margins._16
        self.alignment = .fill
        self.distribution = .fill
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: Margins._16, left: Margins._16, bottom: Margins._16, right: Margins._12)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDeadlineSwitcher() {
        self.addArrangedSubview(deadlineSwitcher)
        
        NSLayoutConstraint.activate([
            deadlineSwitcher.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var deadlineSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = UIColor(named: AccentColors.labelPrimary)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        return switcher
    }()
}
