//
//  TodoItem.DescriptionView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemDescriptionView: UITextView {
    
    // MARK: - Lifesycle Functions
    init() {
        super.init(frame: .zero, textContainer: .none)
        
        setupTextView()
        setupPlaceHolderLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Description View...")
    }
    
    override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        placeholderLabel.isHidden = true
        
        return didBecomeFirstResponder
    }
    
    override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        placeholderLabel.isHidden = !text.isEmpty
        
        return didResignFirstResponder
    }
    
    // MARK: - Setup Functions
    private func setupTextView() {
        self.font = Fonts.getFont(named: .body)
        self.tintColor = UIColor(named: AccentColors.backSecondary)
        self.textColor = UIColor(named: AccentColors.labelPrimary)
        self.autocorrectionType = .no
        self.layer.cornerRadius = Sizes.cornerRadius
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: Sizes.margin_12, left: Sizes.margin_16,
                                               bottom: Sizes.margin_12, right: Sizes.margin_16)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPlaceHolderLabel() {
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Sizes.margin_16),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Sizes.margin_16),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.margin_12),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(named: AccentColors.backSecondary)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.text = Values.taskDescriptionPlacholder
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
