//
//  TodoItem.ScrollView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemScrollView: UIScrollView {
    
    // MARK: - Lifesycle Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        setupDescriptionView()
        setupDetailsStackView(topView: descriptionView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Content Scroll View...")
    }
    
    // MARK: - Setup Functions
    private func setupScrollView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDescriptionView() {
        self.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.margin_2x16),
            descriptionView.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.descriptionMinHeight),
        ])
    }
    
    
    private func setupDetailsStackView(topView: UIView) {
        self.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            detailsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            detailsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.margin_2x16),
            detailsStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Sizes.margin_16)
        ])
    }
    
    // MARK: - UI Elements
    private lazy var descriptionView = TodoItemDescriptionView()
    
    private lazy var detailsStackView = TodoItemDetailsStackView()
}
