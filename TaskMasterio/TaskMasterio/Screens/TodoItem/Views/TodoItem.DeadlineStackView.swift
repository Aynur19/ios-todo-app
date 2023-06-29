//
//  TodoItem.DeadlineStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import UIKit

final class TodoItemDeadlineStackView: UIStackView {
    
    private var viewModel: TodoItemViewModel!
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setupDeadlineStackView()
        setupDeadlineLabelsStackView()
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
    
    private func setupDeadlineLabelsStackView() {
        self.addArrangedSubview(deadlineLabelsStackView)
        
        deadlineLabelsStackView.addArrangedSubview(deadlineLabel)
        deadlineLabelsStackView.addArrangedSubview(deadlineDateLabel)
        
        NSLayoutConstraint.activate([
            deadlineLabelsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var deadlineSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = UIColor(named: AccentColors.labelPrimary)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        switcher.addTarget(self, action: #selector(onSwitchTapped(_:)), for: .valueChanged)
        switcher.isOn = viewModel.deadline != nil
        
        return switcher
    }()
    
    private lazy var deadlineLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = Titles.deadline
        label.font = Fonts.getFont(named: .body)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var deadlineDateLabel: UILabel = {
        var label = UILabel()
        label.text = "test"
        label.font = Fonts.getFont(named: .footnote)
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    @objc private func onSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            viewModel.deadline = Date()
        } else {
            viewModel.deadline = nil
        }
        
        print("deadline: \(String(describing: viewModel.deadline))")
    }
}
