//
//  TodoItem.ContentStackView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemContentStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDescriptionView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)

        setupDescriptionView()
    }
    
    private func setupDescriptionView() {
        addArrangedSubview(descriptionView)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.descriptionMinHeight)
        ])
    }
    
    private lazy var descriptionView: UITextView = {
        let textView = TodoItemDescriptionView(frame: .zero)
        textView.font = Fonts.getFont(named: .body)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.layer.cornerRadius = Sizes.cornerRadius
        textView.textColor = UIColor(named: AccentColors.labelPrimary)
        textView.isScrollEnabled = false
        
        return textView
        
    }()
}