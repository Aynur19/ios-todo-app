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
    
    private let optionsContainer = UIView()

    private let priorityContainer = UIView()
    private let priorityLabel = UILabel()
    private let priorutySegmentedControl = UISegmentedControl()
    
    private let deadlineContainer = UIView()
    private let deadlineSwitcher = UISwitch()
    private let deadlineLabel = UILabel()
    
    private let deleteButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        navigationBarPreparing()
        contentPreparing(view)
        
        descriptionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        updatePlaceholderVisibility()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
    
    private func navigationBarPreparing() {
        print("Navigation Bar Preparing...")
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
    

    private func contentPreparing(_ contentView: UIView) {
        print("Content Preparing...")
        contentView.addSubview(scrollView)
        
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(optionsContainer)
        scrollView.addSubview(deleteButton)
        
        descriptionView.addSubview(descriptionPlaceholder)

        optionsContainer.addSubview(priorityContainer)
        optionsContainer.addSubview(deadlineContainer)
        
        priorityContainer.addSubview(priorityLabel)
        priorityContainer.addSubview(priorutySegmentedControl)
        
        deadlineContainer.addSubview(deadlineLabel)
        deadlineContainer.addSubview(deadlineSwitcher)
        
        scrollViewPreparing(scrollView, ownerView: view)
        descriptionViewPreparing(descriptionView, ownerView: scrollView)
        descriptionPlaceholderPreparing(descriptionPlaceholder, ownerView: descriptionView)
        
        optionsContainerPreparing(optionsContainer, ownerView: scrollView, topView: descriptionView, bottomView: deadlineContainer)
        
        priorityContainerPreparing(priorityContainer, ownerView: optionsContainer)
        priorityLabelPreparing(priorityLabel, ownerView: priorityContainer)
        prioritySegmentedControlPreparing(priorutySegmentedControl, ownerView: priorityContainer)
        
        deadlineContainerPreparing(deadlineContainer, ownerView: optionsContainer, topView: priorityContainer)
        deadlineLabelPreparing(deadlineLabel, ownerView: deadlineContainer)
        deadlineSwitcherPreparing(deadlineSwitcher, ownerView: deadlineContainer)
        
        deleteButtonPreparing(deleteButton, ownerView: scrollView, topView: optionsContainer)
    }
    
    private func scrollViewPreparing(_ scrollView: UIScrollView, ownerView: UIView) {
        print("Scroll View Preparing...")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func descriptionViewPreparing(_ descriptionView: UITextView, ownerView: UIView) {
        print("Description View Preparing...")
    
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
            descriptionView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            descriptionView.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            descriptionView.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginTxB),
            
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: ownerView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func descriptionPlaceholderPreparing(_ descriptionPlaceholder: UILabel, ownerView: UIView) {
        print("Description Placeholder Preparing...")
        descriptionPlaceholder.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        descriptionPlaceholder.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionPlaceholder.text = Values.taskDescriptionPlacholder
        descriptionPlaceholder.textColor = UIColor(named: AccentColors.labelTertiary)
        
        descriptionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionPlaceholder.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            descriptionPlaceholder.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            descriptionPlaceholder.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginV),
        ])
    }
    
    private func optionsContainerPreparing(_ optionsContainer: UIView, ownerView: UIView, topView: UIView, bottomView: UIView) {
        print("Options Container Preparing...")

        optionsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsContainer.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            optionsContainer.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            optionsContainer.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Sizes.marginTxB),
            optionsContainer.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),

            optionsContainer.widthAnchor.constraint(equalTo: ownerView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func optionsStackViewPreparing(_ optionsStackView: UIStackView, ownerView: UIView) {
        print("Options Stack View Preparing...")
        optionsStackView.axis = .vertical
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsStackView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            optionsStackView.topAnchor.constraint(equalTo: ownerView.topAnchor),
            optionsStackView.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor, constant: -Sizes.marginV_10),
        ])
    }
    
    private func deleteButtonPreparing(_ deleteButton: UIButton, ownerView: UIView, topView: UIView) {
        print("Delete Button Preparing...")
        
        deleteButton.setTitle(Titles.delete, for: .normal)
        deleteButton.backgroundColor = UIColor(named: AccentColors.backSecondary)
        deleteButton.setTitleColor(UIColor(named: AccentColors.colorRed), for: .normal)
        deleteButton.setTitleColor(UIColor(named: AccentColors.labelTertiary), for: .disabled)
        deleteButton.layer.cornerRadius = Sizes.cornerRadius
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            deleteButton.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            deleteButton.bottomAnchor.constraint(lessThanOrEqualTo: ownerView.bottomAnchor, constant: Sizes.zero),
            deleteButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Sizes.marginTxB),
            
            deleteButton.heightAnchor.constraint(equalToConstant: Sizes.deleteButtonHeight),
            deleteButton.widthAnchor.constraint(equalTo: ownerView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
}


extension TodoItemViewController {
    private func priorityContainerPreparing(_ priorityContainer: UIView, ownerView: UIView) {
        print("Priority Container Preparing...")
        priorityContainer.backgroundColor = UIColor(named: AccentColors.backSecondary)

        priorityContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityContainer.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            priorityContainer.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            priorityContainer.topAnchor.constraint(equalTo: ownerView.topAnchor),
        ])
    }
    
    private func priorityLabelPreparing(_ priorityLabel: UILabel, ownerView: UIView) {
        print("Priority Label Preparing...")
        priorityLabel.text = Titles.priority
        priorityLabel.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        priorityLabel.textColor = UIColor(named: AccentColors.labelPrimary)
        
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityLabel.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            priorityLabel.centerYAnchor.constraint(equalTo: ownerView.centerYAnchor),
        ])
    }
    
    private func prioritySegmentedControlPreparing(_ priorutySegmentedControl: UISegmentedControl, ownerView: UIView) {
        print("Priority Segmented Control Preparing...")
        priorutySegmentedControl.insertSegment(withTitle: "low", at: 0, animated: false)
        priorutySegmentedControl.insertSegment(withTitle: "medium", at: 1, animated: false)
        priorutySegmentedControl.insertSegment(withTitle: "high", at: 2, animated: false)
        
        priorutySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorutySegmentedControl.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            priorutySegmentedControl.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginV_10),
            priorutySegmentedControl.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor, constant: -Sizes.marginV_10),
            
            priorutySegmentedControl.heightAnchor.constraint(equalToConstant: 36),
            priorutySegmentedControl.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
        ])
    }
}

extension TodoItemViewController {
    private func deadlineContainerPreparing(_ deadlineContainer: UIView, ownerView: UIView, topView: UIView) {
        print("Deadline Container Preparing...")
        deadlineContainer.backgroundColor = UIColor(named: AccentColors.backSecondary)
        deadlineContainer.backgroundColor = .orange

        deadlineContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineContainer.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            deadlineContainer.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            deadlineContainer.topAnchor.constraint(equalTo: topView.bottomAnchor),
        ])
    }
    
    private func deadlineLabelPreparing(_ deadlineLabel: UILabel, ownerView: UIView) {
        print("Deadline Label Preparing...")
        deadlineLabel.text = Titles.priority
        deadlineLabel.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        deadlineLabel.textColor = UIColor(named: AccentColors.labelPrimary)
        
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineLabel.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            deadlineLabel.centerYAnchor.constraint(equalTo: ownerView.centerYAnchor),
        ])
    }
    
    private func deadlineSwitcherPreparing(_ deadlineSwitcher: UISwitch, ownerView: UIView) {
        print("Deadline Switcher Preparing...")
        
        deadlineSwitcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineSwitcher.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            deadlineSwitcher.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginV_10),
            deadlineSwitcher.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor, constant: -Sizes.marginV_10),
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
