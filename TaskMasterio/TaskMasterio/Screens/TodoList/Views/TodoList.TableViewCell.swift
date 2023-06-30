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
        
        self.updateCompletiinMarkStyle(for: self.completionMark, while: TasksStates.none)
        self.updateDescriptionStyle(for: self.descriptionLabel, while: TasksStates.none)
        self.descriptionLabel.text = nil
    }
    
    deinit {
        completionMark.removeTarget(self, action: #selector(onCompletionMarkTouched), for: .touchUpInside)
    }
    
    func bindViewModel(with viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        self.descriptionLabel.text = viewModel.description
        
        self.cancellables.removeAll()
        self.viewModel.$taskState
            .sink { [weak self] taskState in
                self?.updateCompletiinMarkStyle(for: self?.completionMark, while: taskState)
                self?.updatePriorityImage(for: self?.prioriryImage, while: taskState)
                self?.updateDescriptionStyle(for: self?.descriptionLabel, while: taskState)
            }
            .store(in: &cancellables)
        
        self.viewModel.deadlineStr
            .sink { [weak self] deadlineStr in
                if deadlineStr != nil, !deadlineStr!.isEmpty {
                    self?.deadlineImage.isHidden = false
                    self?.deadlineLabel.isHidden = false
                    self?.deadlineImage.image = UIImage(named: "Calendar")
                    self?.deadlineLabel.text = deadlineStr
                } else {
                    self?.deadlineImage.isHidden = true
                    self?.deadlineLabel.isHidden = true
                }
            }
            .store(in: &cancellables)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        let deadlineStack = getStackView(subviews: [deadlineImage, deadlineLabel], spacing: 2)
        NSLayoutConstraint.activate([
            deadlineImage.widthAnchor.constraint(equalToConstant: 16),
            deadlineImage.heightAnchor.constraint(equalToConstant: 16),
            deadlineImage.centerYAnchor.constraint(equalTo: deadlineStack.centerYAnchor),
        ])
        
        let descriptionStack = getStackView(subviews: [descriptionLabel, deadlineStack], axis: .vertical, alignment: .leading)
        let priorityStack = getStackView(subviews: [prioriryImage, descriptionStack], spacing: 2)
        
        NSLayoutConstraint.activate([
            prioriryImage.widthAnchor.constraint(equalToConstant: 16),
            prioriryImage.heightAnchor.constraint(equalToConstant: 20),
            prioriryImage.centerYAnchor.constraint(equalTo: priorityStack.centerYAnchor),
        ])
        
        let completionMarkStack = getStackView(subviews: [completionMark, priorityStack], spacing: 12)
        let fullStack = getStackView(subviews: [completionMarkStack, shevronView], spacing: 16)
        
        contentView.addSubview(fullStack)
        NSLayoutConstraint.activate([
            fullStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins._16),
            fullStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins._16),
            fullStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins._16),
            fullStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins._16),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var completionMark: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCompletionMarkTouched), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var prioriryImage = getImageView()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = descriptionRowsCount
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var deadlineImage = getImageView()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.font = Fonts.getFont(named: .subhead)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var shevronView: UIImageView = {
        let shevron = UIImageView()
        shevron.image = UIImage(named: "Arrow. Right")
        shevron.translatesAutoresizingMaskIntoConstraints = false
        
        return shevron
    }()

    private func getStackView(subviews: [UIView],
                              axis: NSLayoutConstraint.Axis = .horizontal,
                              spacing: CGFloat = 0,
                              alignment: UIStackView.Alignment = .center) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        updatedButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func updatePriorityImage(for imageView: UIImageView?, while taskState: TasksStates) {
        guard let imageView = imageView else { return }
        var image: UIImage?
        
        switch taskState {
        case .lowPriority:
            image = UIImage(named: "low")
        case .highPriority:
            image = UIImage(named: "high")
        default:
            image = nil
        }
        
        imageView.image = image
    }
    
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
    
    
    @objc private func onCompletionMarkTouched() {
        viewModel.changeTaskCompletion()
    }
}
