//
//  TodoItem.ScrollView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupContentStackView()
    }
    
    private func setupContentStackView() {
        addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.margin2xH),
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.spacingV),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Sizes.spacingV),
        ])
    }
    
    private lazy var contentStackView: UIStackView = {
        let stackView = TodoItemContentStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = Sizes.spacingV
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
}
