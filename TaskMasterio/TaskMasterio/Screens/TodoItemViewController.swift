//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController {
    
    let taskTitle = "Дело"
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()
    
    private let stackView = UIStackView()
    
    private let priorityContainer = UIView()
    private let priorityStackView = UIStackView()
    private let priorityLabel = UILabel()
    private let priorutySegmentedControl = UISegmentedControl()
    
    private let deadlineSwitcher = UISwitch()
    
    private let deleteButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        prepareNavigationBar()
        prepareContent()
        
        descriptionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        updatePlaceholderVisibility()
    }
    
    private func prepareNavigationBar() {
        print("1. Prepearing Navigation Bar...")
        if let navigationController = self.navigationController {
            title = taskTitle
            navigationController.navigationBar.barStyle = .default
            
            let cancelButton = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self,
                                               action: #selector(cancelButtonTapped))
            
            let saveButton = UIBarButtonItem(title: Titles.save, style: .plain, target: self,
                                             action: #selector(saveButtonTapped))
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
    
    private func prepareContent() {
        print("2. Prepearing content...")
        view.addSubview(scrollView)
        
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(priorityContainer)
        scrollView.addSubview(deleteButton)
        
        descriptionView.addSubview(descriptionPlaceholder)
        priorityContainer.addSubview(priorityStackView)
        priorityStackView.addSubview(priorityLabel)
        priorityStackView.addSubview(priorutySegmentedControl)
        
        prepareScrollView()
        prepareDescriptionView()
        prepareDescriptionPlaceholder()
        
        //        scrollView.addSubview(stackView)
        //        prepareStackView()
        
        preparePriorityContainer()
        preparePriorityStackView()
        preparePriorityLabel()
        preparePrioritySegmentedControl()
        prepareDeleteButton()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func prepareScrollView() {
        print("3. Prepearing Scroll View...")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func prepareDescriptionView() {
        print("4. Prepearing Description View...")
        descriptionView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        descriptionView.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionView.layer.cornerRadius = Sizes.cornerRadius
        descriptionView.textColor = UIColor(named: AccentColors.labelPrimary)
        descriptionView.isScrollEnabled = false
        descriptionView.textContainerInset = UIEdgeInsets(top: Sizes.marginV, left: Sizes.marginH,
                                                          bottom: Sizes.marginH, right: Sizes.marginH)
        
        
        descriptionView.clipsToBounds = true
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            descriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            descriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Sizes.marginTxB),
            
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func prepareDescriptionPlaceholder() {
        print("5. Prepearing Description Placeholder...")
        descriptionPlaceholder.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        descriptionPlaceholder.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionPlaceholder.text = Values.taskDescriptionPlacholder
        descriptionPlaceholder.textColor = UIColor(named: AccentColors.labelTertiary)
        
        descriptionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionPlaceholder.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: Sizes.marginH),
            descriptionPlaceholder.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -Sizes.marginH),
            descriptionPlaceholder.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Sizes.marginV),
        ])
        
    }
    
    private func prepareStackView() {
        print("6. Prepearing Scack View...")
        stackView.axis = .vertical
        stackView.tintColor = UIColor(named: AccentColors.backSecondary)
        //        stackView.alignment = .
        stackView.addSubview(priorityStackView)
        stackView.layer.cornerRadius = Sizes.cornerRadius
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            stackView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Sizes.marginTxB),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func preparePriorityContainer() {
        print("6. Prepearing Priority Container...")
        priorityContainer.backgroundColor = UIColor(named: AccentColors.backSecondary)
        //        priorityContainer.tintColor = UIColor(named: AccentColors.backSecondary)
        priorityContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            priorityContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            priorityContainer.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Sizes.marginTxB),
            priorityContainer.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -Sizes.marginTxB),
            
            priorityContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func preparePriorityStackView() {
        
        print("8. Prepearing Priority Stack View...")
        priorityStackView.axis = .horizontal
        priorityStackView.spacing = Sizes.marginH
        //        priorityStackView.distribution = .fill
        //        priorityStackView.alignment = .fill
        //        priorityStackView.tintColor = UIColor(named: AccentColors.backSecondary)
        //        stackView.alignment = .
        //        priorityStackView.addSubview(priorutySegmentedControl)
        
        
        priorityStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityStackView.leadingAnchor.constraint(equalTo: priorityContainer.leadingAnchor, constant: Sizes.marginH),
            priorityStackView.trailingAnchor.constraint(equalTo: priorityContainer.trailingAnchor, constant: -Sizes.marginH),
            priorityStackView.topAnchor.constraint(equalTo: priorityContainer.topAnchor, constant: Sizes.marginV_10),
            priorityStackView.bottomAnchor.constraint(equalTo: priorityContainer.bottomAnchor, constant: -Sizes.marginV_10),
            
            //            priorityStackView.widthAnchor.constraint(equalTo: priorityContainer.widthAnchor, constant: -Sizes.margin2xH),
            
            //            priorityStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            //            priorityStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            //            priorityStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            //
            //            priorityStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
        
        
        //        preparePrioritySegmentedControl()
    }
    
    private func preparePriorityLabel() {
        
        print("9. Prepearing Priority Label...")
        priorityLabel.text = Titles.priority
        priorityLabel.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        priorityLabel.textColor = UIColor(named: AccentColors.labelPrimary)
        
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityLabel.leadingAnchor.constraint(equalTo: priorityStackView.leadingAnchor),
            priorityLabel.topAnchor.constraint(equalTo: priorityStackView.topAnchor),
            priorityLabel.bottomAnchor.constraint(equalTo: priorityStackView.bottomAnchor),
            
            //            priorityLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
        ])
    }
    
    private func preparePrioritySegmentedControl() {
        print("10. Prepearing Priority Segment Control...")
        priorutySegmentedControl.insertSegment(withTitle: "low", at: 0, animated: false)
        priorutySegmentedControl.insertSegment(withTitle: "medium", at: 1, animated: false)
        priorutySegmentedControl.insertSegment(withTitle: "high", at: 2, animated: false)
        
        priorutySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorutySegmentedControl.trailingAnchor.constraint(equalTo: priorityStackView.trailingAnchor),
            priorutySegmentedControl.topAnchor.constraint(equalTo: priorityStackView.topAnchor),//, constant: Sizes.marginV_10),
            priorutySegmentedControl.bottomAnchor.constraint(equalTo: priorityStackView.bottomAnchor),//, constant: -Sizes.marginV_10),
            
            priorutySegmentedControl.heightAnchor.constraint(equalToConstant: 36),
            priorutySegmentedControl.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
        ])
    }
    
    private func prepareDeleteButton() {
        print("11. Prepearing Delete Button...")
        deleteButton.setTitle(Titles.delete, for: .normal)
        deleteButton.backgroundColor = UIColor(named: AccentColors.backSecondary)
        deleteButton.setTitleColor(UIColor(named: AccentColors.colorRed), for: .normal)
        deleteButton.setTitleColor(UIColor(named: AccentColors.labelTertiary), for: .disabled)
        deleteButton.layer.cornerRadius = Sizes.cornerRadius
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            deleteButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            deleteButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: Sizes.zero),
            deleteButton.topAnchor.constraint(equalTo: priorityContainer.bottomAnchor, constant: Sizes.marginTxB),
            //            deleteButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Sizes.marginTxB),
            
            deleteButton.heightAnchor.constraint(equalToConstant: Sizes.deleteButtonHeight),
            deleteButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
}

// MARK: - UITextViewDelegate
extension TodoItemViewController: UITextViewDelegate {
    @objc private func textDidChange() {
        updatePlaceholderVisibility()
    }
    
    private func updatePlaceholderVisibility() {
        descriptionPlaceholder.isHidden = !descriptionView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
}
