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
                    self?.deadlineImage.image = UIImage(named: "Calendar")
                    self?.deadlineLabel.text = deadlineStr
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
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins._16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins._16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins._16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins._16),
        ])
        
        let stakV = UIStackView()
        stakV.axis = .vertical
        stakV.alignment = .leading
        stakV.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        let stackH2 = UIStackView(arrangedSubviews: [prioriryImage, descriptionLabel])
        stackH2.axis = .horizontal
        stackH2.spacing = 2
        stackH2.alignment = .center
        stackH2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            prioriryImage.widthAnchor.constraint(equalToConstant: 16),
            prioriryImage.heightAnchor.constraint(equalToConstant: 20),
            prioriryImage.centerYAnchor.constraint(equalTo: stackH2.centerYAnchor),
        ])
        
        
        let stackH = UIStackView(arrangedSubviews: [deadlineImage, deadlineLabel])
        stackH.axis = .horizontal
        stackH.spacing = 2
        stackH.alignment = .center
        stackH.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            deadlineImage.widthAnchor.constraint(equalToConstant: 16),
            deadlineImage.heightAnchor.constraint(equalToConstant: 16),
            deadlineImage.centerYAnchor.constraint(equalTo: stackH.centerYAnchor),
        ])
        
        
        let stackV = UIStackView(arrangedSubviews: [stackH2, stackH])
        stackV.axis = .vertical
        stackV.alignment = .leading
        stackV.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackH3 = UIStackView(arrangedSubviews: [completionMark, stackV])
        stackH3.axis = .horizontal
        stackH3.spacing = 12
        stackH3.alignment = .center
        stackH3.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackH4 = UIStackView(arrangedSubviews: [stackH3, shevronView])
        stackH4.axis = .horizontal
        stackH4.spacing = 16
        stackH4.alignment = .center
        stackH4.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackH4)
        NSLayoutConstraint.activate([
            stackH4.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackH4.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackH4.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackH4.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
    }
    
    // MARK: - UI Elements
    private lazy var containerView = getContainer()
    
    private lazy var completionMark: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCompletionMarkTouched), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var detailsContainerView = getContainer()
    
    private lazy var descriptionContainerView = getContainer()
    
    private lazy var prioriryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = descriptionRowsCount
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var deadlineImage: UIImageView = {
        let shevron = UIImageView()
//        shevron.image = UIImage(named: "Calendar") ?? UIImage()
        shevron.translatesAutoresizingMaskIntoConstraints = false
        
        return shevron
    }()
    
    private func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "30 июня"
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.font = Fonts.getFont(named: .subhead)
        //        shevron.image = UIImage(named: "Calendar") ?? UIImage()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var shevronView: UIImageView = {
        let shevron = UIImageView()
        shevron.image = UIImage(named: "Arrow. Right") ?? UIImage()
        shevron.translatesAutoresizingMaskIntoConstraints = false
        
        return shevron
    }()
    
    private func getContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
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
