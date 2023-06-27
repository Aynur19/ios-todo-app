//
//  TodoItem.DescriptionView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemDescriptionView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupPlaceHolderLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupPlaceHolderLabel()
    }
    
    private func setupPlaceHolderLabel() {
        addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Sizes.marginH),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Sizes.marginH),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.marginV),
        ])
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(named: AccentColors.backSecondary)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.text = Values.taskDescriptionPlacholder
        
        return label
    }()
}
