//
//  TodoItem.PriorityStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 28.06.2023.
//

import UIKit

final class TodoItemPriorityStackView: UIStackView {
    
    private var viewModel: TodoItemViewModel!
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
        setupPriorityLabel()
        setupPrioritySegmentedControl()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Priority Stack View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.axis = .horizontal
        self.spacing = Sizes.margin_16
        self.alignment = .fill
        self.distribution = .fill
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: Sizes.margin_10, left: Sizes.margin_16, bottom: Sizes.margin_10, right: Sizes.margin_12)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPriorityLabel() {
        self.addArrangedSubview(priorityLabel)
        
        NSLayoutConstraint.activate([
            priorityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setupPrioritySegmentedControl() {
        self.addArrangedSubview(prioritySegmentedControl)
        
        NSLayoutConstraint.activate([
            prioritySegmentedControl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
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
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        let low = UIImage(named: Priority.low.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorGrey) ?? .gray, renderingMode: .alwaysOriginal)
        let high = UIImage(named: Priority.high.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorRed) ?? .red, renderingMode: .alwaysOriginal)
        
        segmentedControl.insertSegment(with: low, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Values.priorityMedium, at: 1, animated: false)
        segmentedControl.insertSegment(with: high, at: 2, animated: false)
        
        let font = [NSAttributedString.Key.font: Fonts.getFont(named: .subhead)]
        segmentedControl.setTitleTextAttributes(font, for: .normal)
        segmentedControl.setTitleTextAttributes(font, for: .selected)
        
        let foregroundColor = [NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label]
        segmentedControl.setTitleTextAttributes(foregroundColor, for: .normal)
        segmentedControl.setTitleTextAttributes(foregroundColor, for: .selected)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.selectedSegmentIndex = viewModel?.priority?.index ?? Priority.medium.index
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        viewModel.priority = Priority.getPriority(selectedIndex)
    }
}
