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
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.marginH),
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Sizes.spacingV
        stackView.alignment = .center
        
        return stackView
    }()
}
