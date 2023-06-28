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
        addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: Sizes.margin_2x16),
            descriptionView.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.descriptionMinHeight),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var descriptionView = TodoItemDescriptionView()
}
//    private func setupContentStackView() {
//        addSubview(contentStackView)
//
//        NSLayoutConstraint.activate([
//            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.margin2xH),
//            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.spacingV),
//            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Sizes.spacingV),
//        ])
//    }
//
//    private lazy var contentStackView: UIStackView = {
//        let stackView = TodoItemContentStackView(frame: .zero)
//        stackView.axis = .vertical
//        stackView.spacing = Sizes.spacingV
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        return stackView
//    }()
//}
