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
        self.spacing = Margins.mg16
        self.alignment = .fill
        self.distribution = .fill
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: Margins.mg10, left: Margins.mg16, bottom: Margins.mg10, right: Margins.mg12)
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
        label.font = Fonts.body
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        let low = UIImage(named: TodoItemPriority.low.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorGrey) ?? .gray, renderingMode: .alwaysOriginal)
        let high = UIImage(named: TodoItemPriority.high.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorRed) ?? .red, renderingMode: .alwaysOriginal)
        
        segmentedControl.insertSegment(with: low, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Values.priorityMedium, at: 1, animated: false)
        segmentedControl.insertSegment(with: high, at: 2, animated: false)
        
        let font = [NSAttributedString.Key.font: Fonts.subhead]
        segmentedControl.setTitleTextAttributes(font, for: .normal)
        segmentedControl.setTitleTextAttributes(font, for: .selected)
        
        let foregroundColor = [NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label]
        segmentedControl.setTitleTextAttributes(foregroundColor, for: .normal)
        segmentedControl.setTitleTextAttributes(foregroundColor, for: .selected)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.selectedSegmentIndex = viewModel?.priority.index ?? TodoItemPriority.medium.index
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        viewModel.updatePriority(priorityIndex: selectedIndex)
    }
}
