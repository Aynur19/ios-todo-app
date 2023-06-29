//
//  TodoItem.ScrollView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit
//import Combine

final class TodoItemScrollView: UIScrollView {
  
    private var viewModel: TodoItemViewModel!
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
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
    
//    func configure(with viewModel: TodoItemViewModel) {
//        descriptionView.configure(with: viewModel)
//        detailsStackView.configure(with: viewModel)
//    }
    
    // MARK: - UI Elements
    private lazy var descriptionView = TodoItemDescriptionView(with: viewModel)
    
    private lazy var detailsStackView = TodoItemDetailsStackView(with: viewModel)
}
