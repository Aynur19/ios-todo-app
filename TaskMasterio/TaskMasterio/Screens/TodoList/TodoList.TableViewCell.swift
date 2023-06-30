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
    private var cancellables = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.updateDescriptionStyle(for: self.descriptionLabel, while: .none)
        self.descriptionLabel.text = nil
    }
    
    func bindViewModel(with viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        self.descriptionLabel.text = viewModel.description
        
        self.viewModel.$taskState
            .sink { [weak self] taskState in
                self?.updateCompletiinMarkStyle(for: self?.completionMark, while: taskState)
                self?.updateDescriptionStyle(for: self?.descriptionLabel, while: taskState)
            }
            .store(in: &cancellables)
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
        
        button.addTarget(self, action: #selector(onCompletionMarkTouched), for: .touchUpInside)
        
        return button
    }()
    
    private func updateDescriptionStyle(for label: UILabel?, while taskState: TasksStates) {
        guard let updatedLabel = label else { return }
        
        var attributedString: NSMutableAttributedString
        var color: UIColor
        
        switch taskState {
        case .isDone:
            attributedString = NSMutableAttributedString(string: updatedLabel.text ?? "", attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
            ])
            color = UIColor(named: AccentColors.labelTertiary) ?? .label
        default:
            attributedString = NSMutableAttributedString(attributedString: updatedLabel.attributedText ?? NSAttributedString(string: ""))
            attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
            color = UIColor(named: AccentColors.labelPrimary) ?? .secondaryLabel
        }
        
        updatedLabel.attributedText = attributedString
        updatedLabel.textColor = color
    }
    
    private func updateCompletiinMarkStyle(for button: UIButton?, while taskState: TasksStates) {
        guard let updatedButton = button else { return }
        var image: UIImage?
        
        switch taskState {
        case .isDone:
            image = UIImage(named: "Mark. On")
        case .highPriority:
            image = UIImage(named: "Mark. High Priority")
        default:
            image = UIImage(named: "Mark. Off")
        }
        
        updatedButton.setImage(image, for: .normal)
    }
    
    @objc private func onCompletionMarkTouched() {
        viewModel.changeTaskCompletion()
    }
}
