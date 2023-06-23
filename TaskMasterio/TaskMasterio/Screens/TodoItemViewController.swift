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
    
    private let optionsStackView = UIStackView()
    
    private let priorityStackView = UIStackView()
    private let priorityContainer = UIView()
    private let priorityLabel = UILabel()
    private let prioritySegmentedControl = UISegmentedControl()
    
    private let deadlineContainer = UIView()
    private let deadlineSwitcher = UISwitch()
    private let deadlineLabel = UILabel()
    
    private let datePicker = UIDatePicker()
    
    private let deleteButton = UIButton(type: .system)
    
    var datePickerHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        navigationBarPreparing()
        contentPreparing(view)
        
        descriptionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        
        deadlineSwitcher.addTarget(self, action: #selector(deadlineSwitched(_:)), for: .valueChanged)
        descriptionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        updatePlaceholderVisibility()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        descriptionView.removeObserver(self, forKeyPath: "contentSize")
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
    
    
    private func navigationBarPreparing() {
        print("Navigation Bar Preparing...")
        if let navigationController = self.navigationController {
            title = taskTitle
            navigationController.navigationBar.barStyle = .default
            
            let cancelButton = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
            let saveButton = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(saveButtonTapped))
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    
    private func contentPreparing(_ contentView: UIView) {
        print("Content Preparing...")
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor),
        ])
        
        scrollView.addSubview(contentStackView)
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.alignment = .center
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
        
        contentStackView.addArrangedSubview(descriptionView)
        descriptionView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        descriptionView.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionView.layer.cornerRadius = Sizes.cornerRadius
        descriptionView.textColor = UIColor(named: AccentColors.labelPrimary)
        descriptionView.isScrollEnabled = false
        descriptionView.textContainerInset = UIEdgeInsets(top: Sizes.marginV, left: Sizes.marginH, bottom: Sizes.marginH, right: Sizes.marginH)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
        ])
        
        descriptionView.addSubview(descriptionPlaceholder)
        descriptionPlaceholder.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionPlaceholder.text = Values.taskDescriptionPlacholder
        descriptionPlaceholder.textColor = UIColor(named: AccentColors.labelTertiary)
        
        descriptionPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionPlaceholder.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: Sizes.marginH),
            descriptionPlaceholder.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -Sizes.marginH),
            descriptionPlaceholder.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Sizes.marginV),
        ])
        
        contentStackView.addArrangedSubview(optionsStackView)
        optionsStackView.axis = .vertical
        //        optionsStackView.spacing = 16
        optionsStackView.alignment = .center
        optionsStackView.backgroundColor = .white
        optionsStackView.layer.cornerRadius = 16
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //            optionsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            //            optionsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            optionsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Sizes.margin2xH),
        ])
        
        let priorityContainer = UIView()
        optionsStackView.addArrangedSubview(priorityContainer)
        //        priorityContainer.backgroundColor = .systemPink
        priorityContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityContainer.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
        ])
        
        priorityContainer.addSubview(priorityStackView)
        priorityStackView.axis = .horizontal
        priorityStackView.spacing = 16
        //        priorityStackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        //        priorityStackView.backgroundColor = .orange
        priorityStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityStackView.centerXAnchor.constraint(equalTo: priorityContainer.centerXAnchor),
            priorityStackView.widthAnchor.constraint(equalTo: priorityContainer.widthAnchor, constant: -Sizes.margin2xH),
            priorityStackView.topAnchor.constraint(equalTo: priorityContainer.topAnchor, constant: Sizes.marginH),
            priorityStackView.bottomAnchor.constraint(equalTo: priorityContainer.bottomAnchor, constant: -Sizes.marginH),
        ])
        
        priorityStackView.addArrangedSubview(priorityLabel)
        priorityLabel.text = Titles.priority
        priorityLabel.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        priorityLabel.textColor = UIColor(named: AccentColors.labelPrimary)
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityLabel.centerYAnchor.constraint(equalTo: priorityStackView.centerYAnchor),
        ])
        
        priorityStackView.addArrangedSubview(prioritySegmentedControl)
        prioritySegmentedControl.insertSegment(withTitle: "low", at: 0, animated: false)
        prioritySegmentedControl.insertSegment(withTitle: "medium", at: 1, animated: false)
        prioritySegmentedControl.insertSegment(withTitle: "high", at: 2, animated: false)
        prioritySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            prioritySegmentedControl.centerYAnchor.constraint(equalTo: priorityStackView.centerYAnchor),
            //            prioritySegmentedControl.topAnchor.constraint(equalTo: priorityStackView.topAnchor, constant: 16),
            //            prioritySegmentedControl.bottomAnchor.constraint(equalTo: priorityStackView.bottomAnchor, constant: -16),
            prioritySegmentedControl.centerYAnchor.constraint(equalTo: priorityStackView.centerYAnchor),
            prioritySegmentedControl.heightAnchor.constraint(equalToConstant: 36),
            prioritySegmentedControl.widthAnchor.constraint(equalToConstant: 150),
        ])
        //        priorityStackView.heightAnchor.constraint(equalTo: prioritySegmentedControl.heightAnchor, constant: Sizes.margin2xH).isActive = true
        
        let separator1 = UIView()
        optionsStackView.addArrangedSubview(separator1)
        separator1.backgroundColor = .black
        separator1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator1.heightAnchor.constraint(equalToConstant: 0.5).with(priority: .defaultHigh),
            separator1.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, constant: -Sizes.margin2xH),
            separator1.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
        ])
        
        
        let deadlineContainer = UIView()
        optionsStackView.addArrangedSubview(deadlineContainer)
        //        deadlineContainer.backgroundColor = .brown
        deadlineContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineContainer.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
        ])
        
        let deadlineStackView = UIStackView()
        deadlineContainer.addSubview(deadlineStackView)
        deadlineStackView.axis = .horizontal
        deadlineStackView.spacing = 16
        //        contentStackView.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 12)
        //        deadlineStackView.backgroundColor = .blue
        deadlineStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineStackView.centerXAnchor.constraint(equalTo: deadlineContainer.centerXAnchor),
            deadlineStackView.widthAnchor.constraint(equalTo: deadlineContainer.widthAnchor, constant: -Sizes.margin2xH),
            deadlineStackView.topAnchor.constraint(equalTo: deadlineContainer.topAnchor, constant: Sizes.marginH),
            deadlineStackView.bottomAnchor.constraint(equalTo: deadlineContainer.bottomAnchor, constant: -Sizes.marginH),
            //            deadlineStackView.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, constant: -Sizes.margin2xH),
        ])
        
        deadlineStackView.addArrangedSubview(deadlineLabel)
        deadlineLabel.text = Titles.priority
        deadlineLabel.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        deadlineLabel.textColor = UIColor(named: AccentColors.labelPrimary)
        
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            deadlineLabel.leadingAnchor.constraint(equalTo: deadlineStackView.leadingAnchor, constant: Sizes.marginH),
            deadlineLabel.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
        ])
        
        deadlineStackView.addArrangedSubview(deadlineSwitcher)
        deadlineSwitcher.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            deadlineSwitcher.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
        ])
        
        let deadlinePickerContainer = UIView()
        optionsStackView.addArrangedSubview(deadlinePickerContainer)
        deadlinePickerContainer.backgroundColor = .red
        deadlinePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlinePickerContainer.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
            //            deadlinePickerContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
        ])
        
        optionsStackView.addArrangedSubview(datePicker)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        //                datePicker.sizeToFit()
        //        datePicker.minimumDate = Date()
        //        datePicker.subviews[0].subviews[1].isHidden = false
        //        datePicker.becomeFirstResponder()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        ////        datePicker.showsMenuAsPrimaryAction = false
        //        datePicker.isHidden = true
        ////        datePicker.showsLargeContentViewer = true// .showsSelectionIndicator = false
        ////        datePickerHeightConstraint = datePicker.heightAnchor.constraint(equalToConstant: 0)
        ////        datePickerHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
            datePicker.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, multiplier: 1),
            //                    datePicker.bottomAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
            //            datePicker.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }
    
    //    @objc func dateSwitchChanged(_ sender: UISwitch) {
    //        // Toggle the height constraint between zero and the intrinsic content size of the date picker
    //        let newHeight: CGFloat = datePickerHeightConstraint.constant == 0 ? datePicker.intrinsicContentSize.height : 0
    //
    //        // Animate the change in height of the date picker
    //        UIView.animate(withDuration: 0.3) {
    //            self.datePicker.isHidden = false
    //            self.datePickerHeightConstraint.constant = newHeight
    //            self.view.layoutIfNeeded()
    //        }
    //    }
    
    private func scrollViewPreparing(_ scrollView: UIScrollView, ownerView: UIView) {
        print("Scroll View Preparing...")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: ownerView.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.heightAnchor.constraint(greaterThanOrEqualTo: ownerView.safeAreaLayoutGuide.heightAnchor),
        ])
    }
    
    private func contentStackViewPreparing(_ contentStackView: UIStackView, ownerView: UIView) {
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: ownerView.centerXAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: ownerView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor),
            
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
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //            descriptionView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            //            descriptionView.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: ownerView.widthAnchor),
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
            deleteButton.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor),
            
            deleteButton.heightAnchor.constraint(equalToConstant: Sizes.deleteButtonHeight),
        ])
    }
    
    @objc func deadlineSwitched(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
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
            //            priorityLabel.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor, constant: Sizes.marginH),
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
            //            priorutySegmentedControl.trailingAnchor.constraint(equalTo: ownerView.trailingAnchor, constant: -Sizes.marginH),
            priorutySegmentedControl.topAnchor.constraint(equalTo: ownerView.topAnchor, constant: Sizes.marginV_10),
            priorutySegmentedControl.bottomAnchor.constraint(equalTo: ownerView.bottomAnchor, constant: -Sizes.marginV_10),
            
            priorutySegmentedControl.heightAnchor.constraint(equalToConstant: 36),
            priorutySegmentedControl.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
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
