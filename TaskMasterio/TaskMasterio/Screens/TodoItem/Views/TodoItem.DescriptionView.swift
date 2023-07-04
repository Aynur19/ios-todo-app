//
//  TodoItem.DescriptionView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit
import Combine

final class TodoItemDescriptionView: UITextView {
   
    private var viewModel: TodoItemViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    init(with viewModel: TodoItemViewModel) {
        super.init(frame: .zero, textContainer: .none)
        self.viewModel = viewModel
        
        setup()
        setupPlaceHolderLabel()
        
        bindViewModel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Trying to initialize Todo Item Description View...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        self.font = Fonts.body
        self.tintColor = UIColor(named: AccentColors.backSecondary)
        self.textColor = UIColor(named: AccentColors.labelPrimary)
        self.autocorrectionType = .no
        self.layer.cornerRadius = Sizes.cornerRadius
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: Margins.mg12, left: Margins.mg16,
                                               bottom: Margins.mg12, right: Margins.mg16)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text = viewModel.description
    }
    
    private func setupPlaceHolderLabel() {
        self.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.mg16),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.mg16),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins.mg12),
        ])
    }
    
    func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextView)?.text ?? "" }
            .assign(to: \.description, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.descriptionIsNotEmpty
            .assign(to: \.isHidden, on: placeholderLabel)
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.tintColor = UIColor(named: AccentColors.backSecondary)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.text = Values.taskDescriptionPlacholder
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
