//
//  TodoItem.DeadlineStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import UIKit
import Combine

final class TodoItemDeadlineStackView: UIStackView {
    
    private var viewModel: TodoItemViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
        setupDeadlineLabelsStackView()
        setupDeadlineSwitcher()
        
        bindViewModel()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Deadline Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
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
        
        deadlineSwitcher.isOn = viewModel.deadline != nil
    }
    
    private func setupDeadlineLabelsStackView() {
        self.addArrangedSubview(deadlineLabelsStackView)
        
        deadlineLabelsStackView.addArrangedSubview(deadlineLabel)
        deadlineLabelsStackView.addArrangedSubview(deadlineDateLabel)
        
        NSLayoutConstraint.activate([
            deadlineLabelsStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.deadlineStr
            .assign(to: \.text, on: deadlineDateLabel)
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var deadlineSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = UIColor(named: AccentColors.labelPrimary)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        switcher.addTarget(self, action: #selector(onSwitchTapped(_:)), for: .valueChanged)
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
        label.font = Fonts.getFont(named: .footnote)
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let deadlineDateLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeadlineDateLabelTapped))
        label.addGestureRecognizer(deadlineDateLabelTapGesture)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    @objc private func onSwitchTapped(_ sender: UISwitch) {
        viewModel.isSwitchOn = sender.isOn
        
        if !sender.isOn { viewModel.calendarIsHidden = !sender.isOn }
    }
    
    @objc private func onDeadlineDateLabelTapped() {
        viewModel.calendarIsHidden = !viewModel.calendarIsHidden
    }
}
