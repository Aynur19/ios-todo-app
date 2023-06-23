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
    private let contentStackView = UIStackView()
    
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()
    
    //    private let optionsContainer = UIView()
    private let optionsStackView = UIStackView()
    
    private let priorityContainer = UIView()
    private let priorityLabel = UILabel()
    private let priorutySegmentedControl = UISegmentedControl()
    
    private let deadlineContainer = UIView()
    private let deadlineSwitcher = UISwitch()
    private let deadlineLabel = UILabel()
    
    private let datePicker = UIDatePicker()
    
    private let deleteButton = UIButton(type: .system)
    
    private var stackViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        navigationBarPreparing()
        contentPreparing(view)
        
        descriptionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        
        //        datePicker.addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
        
        descriptionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        updatePlaceholderVisibility()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        descriptionView.removeObserver(self, forKeyPath: "contentSize")
        //        datePicker.removeObserver(self, forKeyPath: "bounds")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            scrollToBottom()
        }
    }
    
    private func scrollToBottom() {
        let contentHeight = descriptionView.contentSize.height
        let scrollOffset = CGPoint(x: 0, y: max(contentHeight - scrollView.bounds.height, 0))
        scrollView.setContentOffset(scrollOffset, animated: true)
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
    
    
    //    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    //        if keyPath == "bounds", let datePicker = object as? UIDatePicker {
    //            updateStackViewHeight(datePicker.bounds.height)
    //        }
    //    }
    //
    //    private func updateStackViewHeight(_ datePickerHeight: CGFloat) {
    //        let contentHeight = optionsStackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    //        stackViewHeightConstraint.constant = contentHeight + datePickerHeight + 32.0
    //    }
    
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
        
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(descriptionView)
        
        descriptionView.addSubview(descriptionPlaceholder)
        
        scrollViewPreparing(scrollView, ownerView: view)
        contentStackViewPreparing(contentStackView, ownerView: scrollView)
        
        descriptionViewPreparing(descriptionView, ownerView: contentStackView)
        descriptionPlaceholderPreparing(descriptionPlaceholder, ownerView: descriptionView)
        //        contentStackView.addArrangedSubview(deleteButton)
        //        contentStackView.addArrangedSubview(optionsStackView)
        //        contentStackView.addArrangedSubview(deleteButton)
        
        //        scrollView.addSubview(descriptionView)
        //        scrollView.addSubview(optionsStackView)
        ////        scrollView.addSubview(optionsContainer)
        //        scrollView.addSubview(deleteButton)
        
        
        //        optionsContainer.addSubview(priorityContainer)
        //        optionsContainer.addSubview(deadlineContainer)
        //        optionsContainer.addSubview(optionsStackView)
        //        optionsStackView.addArrangedSubview(datePicker)
        //
        //        priorityContainer.addSubview(priorityLabel)
        //        priorityContainer.addSubview(priorutySegmentedControl)
        //
        //        deadlineContainer.addSubview(deadlineLabel)
        //        deadlineContainer.addSubview(deadlineSwitcher)
        
        
        
        
        //        optionsContainerPreparing(optionsContainer, ownerView: scrollView, topView: descriptionView, bottomView: deleteButton)
        
        //        optionsStackViewPreparing(optionsStackView, ownerView: scrollView, topView: descriptionView)
        //        priorityContainerPreparing(priorityContainer, ownerView: optionsContainer)
        //        priorityLabelPreparing(priorityLabel, ownerView: priorityContainer)
        //        prioritySegmentedControlPreparing(priorutySegmentedControl, ownerView: priorityContainer)
        //
        //        deadlineContainerPreparing(deadlineContainer, ownerView: optionsContainer, topView: priorityContainer)
        //        deadlineLabelPreparing(deadlineLabel, ownerView: deadlineContainer)
        //        deadlineSwitcherPreparing(deadlineSwitcher, ownerView: deadlineContainer)
        
        //        datePickerPreparing(datePicker, owner: optionsStackView, topView: deadlineContainer, bottomVIew: deleteButton)
        
        //        deleteButtonPreparing(deleteButton, ownerView: contentStackView, topView: descriptionView)
    }
    
    private func scrollViewPreparing(_ scrollView: UIScrollView, ownerView: UIView) {
        print("Scroll View Preparing...")
        //        scrollView.showsHorizontalScrollIndicator = false
        //        scrollView.isScrollEnabled = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.heightAnchor.constraint(greaterThanOrEqualTo: ownerView.safeAreaLayoutGuide.heightAnchor),
            
            //            scrollView.heightAnchor.constraint(equalTo: contentStackView.safeAreaLayoutGuide.heightAnchor),
        ])
    }
    
    private func contentStackViewPreparing(_ contentStackView: UIStackView, ownerView: UIView) {
        contentStackView.axis = .vertical
        //        contentStackView.clipsToBounds = true
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: ownerView.centerXAnchor),
            //            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            //            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: ownerView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor),
            
            
            //            contentStackView.heightAnchor.constraint(greaterThanOrEqualTo: ownerView.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: ownerView.widthAnchor, constant: -Sizes.margin2xH),
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
        
        //        descriptionView.clipsToBounds = true
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),// constant: Sizes.marginH),
            descriptionView.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),// constant: -Sizes.marginH),
            //            descriptionView.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginTxB),
            
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: ownerView.widthAnchor),// constant: -Sizes.margin2xH),
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
        optionsContainer.backgroundColor = .orange
        
        optionsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsContainer.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
            optionsContainer.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            optionsContainer.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Sizes.marginTxB),
            optionsContainer.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -Sizes.marginTxB),
            
            optionsContainer.widthAnchor.constraint(equalTo: ownerView.widthAnchor, constant: -Sizes.margin2xH),
        ])
    }
    
    private func optionsStackViewPreparing(_ optionsStackView: UIStackView, ownerView: UIView, topView: UIView) {
        print("Options Stack View Preparing...")
        optionsStackView.axis = .vertical
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        //        stackViewHeightConstraint = optionsContainer.heightAnchor.constraint(equalTo: optionsContainer.heightAnchor)
        //        stackViewHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            optionsStackView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            optionsStackView.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            optionsStackView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            //            optionsStackView.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor),
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
            //            deleteButton.bottomAnchor.constraint(lessThanOrEqualTo: ownerView.bottomAnchor, constant: Sizes.zero),
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
    
    private func datePickerPreparing(_ datePicker: UIDatePicker, owner: UIView, topView: UIView, bottomVIew: UIView) {
        datePicker.datePickerMode = .date
        //        datePicker.contentMode = .
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: owner.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: owner.trailingAnchor),
            //            datePicker.topAnchor.constraint(equalTo: topView.bottomAnchor),
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
