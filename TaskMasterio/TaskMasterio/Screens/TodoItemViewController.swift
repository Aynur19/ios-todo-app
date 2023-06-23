//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController {
    let taskTitle = "Дело"
    
    var task: TodoItem!
    
    private var taskIsModified = false {
        didSet {
            saveButton.isEnabled = taskIsModified
        }
    }
    private var taskDesciption = ""
    
    // MARK: - UI Elements
    private var cancelButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    
    private var contentScrollView: UIScrollView!
    private var contentStackView: UIStackView!
    
    private var descriptionView: UITextView!
    private var descriptionPlaceholder: UILabel!
    
    private var optionsStackView: UIStackView!
    
    private var priorityStackView: UIStackView!
    private var priorityContainer: UIView!
    private var priorityLabel: UILabel!
    private var prioritySegmentedControl: UISegmentedControl!
    
    private var priorityAndDeadlineSeparator: UIView!
    
    private var deadlineContainer: UIView!
    private var deadlineStackView: UIStackView!
    private var deadlineSwitcher: UISwitch!
    private var deadlineLabelContainer: UIView!
    private var deadlineLabel: UILabel!
    private var deadlineDateLabel: UILabel!
    private var deadlineDatePicker: UIDatePicker!
    
    private var deleteButton: UIButton! //(type: .system)
    
    var datePickerHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        //        if task == nil {
        //            task = TodoItem(text: "Первая задача", priority: .)
        //        }
        
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
        let scrollOffset = CGPoint(x: 0, y: max(contentHeight - contentScrollView.bounds.height, 0))
        contentScrollView.setContentOffset(scrollOffset, animated: true)
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
    
    
    private func navigationBarPreparing() {
        print("Navigation Bar Preparing...")
        if let navigationController = self.navigationController {
            title = taskTitle
            navigationController.navigationBar.barStyle = .default
            
            cancelButton = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
            saveButton = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(saveButtonTapped))
            
            saveButton.isEnabled = taskIsModified
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    
    private func contentPreparing(_ contentView: UIView) {
        creatingUIElements()
        buildingUIElements()
        settingConstraints()
    }
    
    private func creatingUIElements() {
        contentScrollView = getContentScrollView()
        contentStackView = getContentStackView()
        
        descriptionView = getDescriptionView()
        descriptionPlaceholder = getDescriptionPlaceholder()
        
        optionsStackView = getOptionsStackView()
        
        priorityContainer = getPriorityContainer()
        priorityStackView = getPriorityStackView()
        priorityLabel = getPriorityLabel()
        prioritySegmentedControl = getPrioritySegmentedControl()
        
        priorityAndDeadlineSeparator = getOptionsStackSeparator()
        
        deadlineContainer = getDeadlineContainer()
        deadlineStackView = getDeadlineStackView()
        deadlineLabelContainer = getDeadlineLabelContainer()
        deadlineLabel = getDeadlineLabel()
        deadlineDateLabel = getDeadlineDateLabel()
        deadlineSwitcher = getDeadlineSwitcher()
        deadlineDatePicker = getDeadlineDatePicker()
        
        deleteButton = getDeleteButton()
    }
    
    private func buildingUIElements() {
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(descriptionView)
        descriptionView.addSubview(descriptionPlaceholder)
        
        contentStackView.addArrangedSubview(optionsStackView)
        
        optionsStackView.addArrangedSubview(priorityContainer)
        priorityContainer.addSubview(priorityStackView)
        priorityStackView.addArrangedSubview(priorityLabel)
        priorityStackView.addArrangedSubview(prioritySegmentedControl)
        
        optionsStackView.addArrangedSubview(priorityAndDeadlineSeparator)
        
        optionsStackView.addArrangedSubview(deadlineContainer)
        deadlineContainer.addSubview(deadlineStackView)
        deadlineStackView.addArrangedSubview(deadlineLabelContainer)
        deadlineStackView.addArrangedSubview(deadlineSwitcher)
        
        deadlineLabelContainer.addSubview(deadlineLabel)
        deadlineLabelContainer.addSubview(deadlineDateLabel)
        
        optionsStackView.addArrangedSubview(deadlineDatePicker)
        contentStackView.addArrangedSubview(deleteButton)
    }
    
    private func settingConstraints() {
        NSLayoutConstraint.activate([
            // content scroll view
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentScrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor),
            
            // content stack view
            contentStackView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, constant: -Sizes.margin2xH),
            
            // description text view
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            
            // description placeholder
            descriptionPlaceholder.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: Sizes.marginH),
            descriptionPlaceholder.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -Sizes.marginH),
            descriptionPlaceholder.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: Sizes.marginV),
            
            // options stack view
            optionsStackView.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            optionsStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            
            // priority container
            priorityContainer.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
            
            // priority stack view
            priorityStackView.centerXAnchor.constraint(equalTo: priorityContainer.centerXAnchor),
            priorityStackView.widthAnchor.constraint(equalTo: priorityContainer.widthAnchor, constant: -Sizes.margin2xH),
            priorityStackView.topAnchor.constraint(equalTo: priorityContainer.topAnchor, constant: Sizes.marginH),
            priorityStackView.bottomAnchor.constraint(equalTo: priorityContainer.bottomAnchor, constant: -Sizes.marginH),
            
            // priority label
            priorityLabel.centerYAnchor.constraint(equalTo: priorityStackView.centerYAnchor),
            
            // priority segmented control
            prioritySegmentedControl.centerYAnchor.constraint(equalTo: priorityStackView.centerYAnchor),
            prioritySegmentedControl.heightAnchor.constraint(equalToConstant: Sizes.prioritySegmentedControlH),
            prioritySegmentedControl.widthAnchor.constraint(equalToConstant: Sizes.prioritySegmentedControlW),
            
            // separator between priority and deadline
            priorityAndDeadlineSeparator.heightAnchor.constraint(equalToConstant: Sizes.separatorW).with(priority: .defaultHigh),
            priorityAndDeadlineSeparator.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, constant: -Sizes.margin2xH),
            priorityAndDeadlineSeparator.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
            
            // deadline container
            deadlineContainer.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor),
            
            // deadline stack view
            deadlineStackView.centerXAnchor.constraint(equalTo: deadlineContainer.centerXAnchor),
            deadlineStackView.widthAnchor.constraint(equalTo: deadlineContainer.widthAnchor, constant: -Sizes.margin2xH),
            deadlineStackView.topAnchor.constraint(equalTo: deadlineContainer.topAnchor, constant: Sizes.marginH),
            deadlineStackView.bottomAnchor.constraint(equalTo: deadlineContainer.bottomAnchor, constant: -Sizes.marginH),
            
            deadlineLabelContainer.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            
            // deadline label
//            deadlineLabel.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            deadlineLabel.leadingAnchor.constraint(equalTo: deadlineLabelContainer.leadingAnchor),
            deadlineLabel.topAnchor.constraint(equalTo: deadlineLabelContainer.topAnchor),
            
            // deadline label
//            deadlineLabel.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            deadlineDateLabel.leadingAnchor.constraint(equalTo: deadlineLabelContainer.leadingAnchor),
            deadlineDateLabel.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor),
            
            // deadline switcher
            deadlineSwitcher.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            
            // date picker
            deadlineDatePicker.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
            deadlineDatePicker.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, multiplier: 1),
            
            // delete button
            deleteButton.leadingAnchor.constraint(equalTo: optionsStackView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: optionsStackView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: Sizes.deleteButtonHeight),
        ])
    }
    
    
    private func getContentScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }
    
    private func getContentStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Sizes.spacingV
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func getDescriptionView() -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.layer.cornerRadius = Sizes.cornerRadius
        textView.textColor = UIColor(named: AccentColors.labelPrimary)
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: Sizes.marginV, left: Sizes.marginH, bottom: Sizes.marginH, right: Sizes.marginH)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
    
    private func getDescriptionPlaceholder() -> UILabel {
        let placeholder = UILabel()
        placeholder.tintColor = UIColor(named: AccentColors.backSecondary)
        placeholder.text = Values.taskDescriptionPlacholder
        placeholder.textColor = UIColor(named: AccentColors.labelTertiary)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        
        return placeholder
    }
    
    private func getOptionsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = Sizes.cornerRadius
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func getPriorityContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }
    
    private func getPriorityStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Sizes.spacingH
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func getPriorityLabel() -> UILabel {
        let label = UILabel()
        label.text = Titles.priority
        label.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func getPrioritySegmentedControl() -> UISegmentedControl {
        
        let segmentedControl = UISegmentedControl()
        let low = UIImage(named: Priority.low.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorGrey) ?? .gray, renderingMode: .alwaysOriginal)
        let high = UIImage(named: Priority.high.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorRed) ?? .red, renderingMode: .alwaysOriginal)
        
        segmentedControl.insertSegment(with: low, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Values.priorityMedium, at: 1, animated: false)
        segmentedControl.insertSegment(with: high, at: 2, animated: false)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.sfPro_15], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.sfPro_15], for: .selected)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label], for: .selected)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }
    
    private func getOptionsStackSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIColor(named: AccentColors.supportSeparator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }
    
    private func getDeadlineContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }
    
    private func getDeadlineStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Sizes.spacingV
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    private func getDeadlineLabelContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }
    
    private func getDeadlineLabel() -> UILabel {
        let label = UILabel()
        label.text = Titles.deadline
        label.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func getDeadlineDateLabel() -> UILabel {
        let label = UILabel()
        label.text = "test"
        label.font = Fonts.sfPro_13
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func getDeadlineSwitcher() -> UISwitch {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        
        return switcher
    }
    
    private func getDeadlineDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.isHidden = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }
    
    private func getDeleteButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Titles.delete, for: .normal)
        button.backgroundColor = UIColor(named: AccentColors.backSecondary)
        button.setTitleColor(UIColor(named: AccentColors.colorRed), for: .normal)
        button.setTitleColor(UIColor(named: AccentColors.labelTertiary), for: .disabled)
        button.layer.cornerRadius = Sizes.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    @objc func deadlineSwitched(_ sender: UISwitch) {
        deadlineDatePicker.isHidden = !sender.isOn
    }
}


// MARK: - UITextViewDelegate
extension TodoItemViewController: UITextViewDelegate {
    @objc private func textDidChange() {
        updatePlaceholderVisibility()
        
        taskIsModified = descriptionPlaceholder.isHidden
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
