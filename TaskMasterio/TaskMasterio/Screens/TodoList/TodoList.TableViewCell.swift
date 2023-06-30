//
//  TodoList.TableViewCell.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit
import Combine

private let descriptionRowsCount = 3

final class TodoListTableViewCell: UITableViewCell {
    
    private var viewModel: TodoItemViewModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionLabel.text = nil
    }
    
    func configure(with viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        
        descriptionLabel.text = viewModel.description
        return
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(completionMark)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Margins._2x16),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -Margins._2x16),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            completionMark.heightAnchor.constraint(equalToConstant: 24),
            completionMark.widthAnchor.constraint(equalToConstant: 24),
            completionMark.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            completionMark.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: completionMark.trailingAnchor, constant: Margins._16),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -Margins._16),
            descriptionLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor),
        ])
        
    }
    
    // MARK: - UI Elements
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = descriptionRowsCount
        label.font = Fonts.getFont(named: .body)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var completionMark: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Mark. Off")
        button.setImage(image, for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
}
