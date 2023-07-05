//
//  TodoItem.ScrollView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemScrollView: UIScrollView {
  
    private var viewModel: TodoItemViewModel!
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        setup()
        setupDescriptionView()
        setupDetailsStackView(topView: descriptionView)
        setupRemoveButton(topView: detailsStackView)
        
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Content Scroll View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDescriptionView() {
        self.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins.mg32),
            descriptionView.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionView.bottomAnchor.constraint(lessThanOrEqualTo: self.keyboardLayoutGuide.topAnchor, constant: -Margins.mg16),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.descriptionMinHeight),
        ])
        descriptionView.contentSize = self.bounds.size
    }
    
    private func setupDetailsStackView(topView: UIView) {
        self.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            detailsStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            detailsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins.mg32),
            detailsStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Margins.mg16)
        ])
    }
    
    private func setupRemoveButton(topView: UIView) {
        self.addSubview(removeButton)
        
        NSLayoutConstraint.activate([
            removeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            removeButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Margins.mg32),
            removeButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Margins.mg16),
            removeButton.heightAnchor.constraint(equalToConstant: Sizes.buttonH),
            
            removeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins.mg16),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var descriptionView = TodoItemDescriptionView(with: viewModel)
    
    private lazy var detailsStackView = TodoItemDetailsStackView(with: viewModel)
    
    private lazy var removeButton = TodoItemRemoveButton(with: viewModel)
}
