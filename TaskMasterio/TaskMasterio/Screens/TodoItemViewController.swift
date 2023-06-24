//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController {
    var task: TodoItem!
    
    private let fileCache = FileCache()
    
    private var text: String = ""
    private var priority: Priority = .medium
    private var deadline: Date?
    
    private var taskIsModified = false {
        didSet {
            saveButton.isEnabled = taskIsModified
        }
    }
    private var taskDesciption = ""
    
    // MARK: - UI Elements
    private var cancelButton: UIBarButtonItem!
    private var saveButton: UIBarButtonItem!
    
    private let contentScrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()
    
    private let optionsStackView = UIStackView()
    
    private let priorityStackView = UIStackView()
    private let priorityContainer = UIView()
    private let priorityLabel = UILabel()
    private let prioritySegmentedControl = UISegmentedControl()
    
    private let priorityAndDeadlineSeparator = UIView()
    
    private let deadlineContainer = UIView()
    private let deadlineStackView = UIStackView()
    private let deadlineSwitcher = UISwitch()
    private let deadlineLabelContainer = UIView()
    private let deadlineLabel = UILabel()
    private let deadlineDateLabel = UILabel()
    
    private let deadlineCalendarSeparator = UIView()
    private let deadlineDatePicker = UIDatePicker()
    
    private let deleteButton = UIButton(type: .system)
    
    private var deadlineDateLabelTapGesture: UITapGestureRecognizer!
    
    var datePickerHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        if let currentTask = task {
            print(currentTask)
        } else {
            print("uupss...")
        }
        
        navigationBarPreparing()
        contentPreparing(view)
        
        descriptionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        
        deadlineSwitcher.addTarget(self, action: #selector(deadlineSwitched(_:)), for: .valueChanged)
        descriptionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        updatePlaceholderVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deadlineLabel.removeGestureRecognizer(deadlineDateLabelTapGesture)
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
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        saveTask()
    }
    
    
    private func navigationBarPreparing() {
        print("Navigation Bar Preparing...")
        if let navigationController = self.navigationController {
            title = Titles.task
            navigationController.navigationBar.barStyle = .default
            
            cancelButton = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(cancelButtonTapped))
            saveButton = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(saveButtonTapped))
            
            saveButton.isEnabled = taskIsModified
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    
    private func contentPreparing(_ contentView: UIView) {
        buildingUIElements()
        settingConstraints()
        configureUIEliments()
    }
    
    private func buildingUIElements() {
        view.addSubview(buildContentScrollView(contentScrollView))
        contentScrollView.addSubview(buildContentStackView(contentStackView))
        
        contentStackView.addArrangedSubview(buildDescriptionView(descriptionView))
        descriptionView.addSubview(buildDescriptionPlaceholder(descriptionPlaceholder))
        
        contentStackView.addArrangedSubview(buildOptionsStackView(optionsStackView))
        
        optionsStackView.addArrangedSubview(buildPriorityContainer(priorityContainer))
        priorityContainer.addSubview(buildPriorityStackView(priorityStackView))
        priorityStackView.addArrangedSubview(buildPriorityLabel(priorityLabel))
        priorityStackView.addArrangedSubview(buildPrioritySegmentedControl(prioritySegmentedControl))
        
        optionsStackView.addArrangedSubview(buildOptionsStackSeparator(priorityAndDeadlineSeparator))
        
        optionsStackView.addArrangedSubview(buildDeadlineContainer(deadlineContainer))
        deadlineContainer.addSubview(buildDeadlineStackView(deadlineStackView))
        deadlineStackView.addArrangedSubview(buildDeadlineLabelContainer(deadlineLabelContainer))
        deadlineStackView.addArrangedSubview(buildDeadlineSwitcher(deadlineSwitcher))
        
        deadlineLabelContainer.addSubview(buildDeadlineLabel(deadlineLabel))
        deadlineLabelContainer.addSubview(buildDeadlineDateLabel(deadlineDateLabel))
        
        optionsStackView.addArrangedSubview(buildDeadlineCalendarSeparator(deadlineCalendarSeparator))
        optionsStackView.addArrangedSubview(buildDeadlineDatePicker(deadlineDatePicker))
        contentStackView.addArrangedSubview(buildDeleteButton(deleteButton))
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
            
            // deadline labels container
            deadlineLabelContainer.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            
            // deadline label
            deadlineLabel.leadingAnchor.constraint(equalTo: deadlineLabelContainer.leadingAnchor),
            deadlineLabel.topAnchor.constraint(equalTo: deadlineLabelContainer.topAnchor),
            
            // deadline date label
            deadlineDateLabel.leadingAnchor.constraint(equalTo: deadlineLabelContainer.leadingAnchor),
            deadlineDateLabel.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor),
            
            // deadline switcher
            deadlineSwitcher.centerYAnchor.constraint(equalTo: deadlineStackView.centerYAnchor),
            
            // separator between deadline switcher and deadline date picker
            deadlineCalendarSeparator.heightAnchor.constraint(equalToConstant: Sizes.separatorW).with(priority: .defaultHigh),
            deadlineCalendarSeparator.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, constant: -Sizes.margin2xH),
            deadlineCalendarSeparator.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
            
            // date picker
            deadlineDatePicker.centerXAnchor.constraint(equalTo: optionsStackView.centerXAnchor),
            deadlineDatePicker.widthAnchor.constraint(equalTo: optionsStackView.widthAnchor, multiplier: 1),
            
            // delete button
            deleteButton.leadingAnchor.constraint(equalTo: optionsStackView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: optionsStackView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: Sizes.deleteButtonHeight),
        ])
    }
    
    private func configureUIEliments() {
        deadlineDateLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDeadlineDateLabelTapped))
        deadlineDateLabel.addGestureRecognizer(deadlineDateLabelTapGesture)
        deadlineDateLabel.isUserInteractionEnabled = true
        
        deadlineDatePicker.addTarget(self, action: #selector(onDeadlineDateChanged(_:)), for: .valueChanged)
        
        updateDeadlineCalendarVisibility()
        //        setDefaultPriority()
        setDefaultValues()
    }
    
    private func updateDeadlineCalendarVisibility(isHidden: Bool = true) {
        deadlineCalendarSeparator.isHidden = isHidden
        deadlineDatePicker.isHidden = isHidden
    }
    
    @objc func deadlineSwitched(_ sender: UISwitch) {
        updateDeadlineCalendarVisibility(isHidden: !sender.isOn)
        
        if sender.isOn {
            setDefaultDeadline()
        } else {
            deadlineDateLabel.text = ""
            deadline = nil
        }
    }
    
    @objc func onDeadlineDateLabelTapped() {
        updateDeadlineCalendarVisibility(isHidden: !deadlineDatePicker.isHidden)
    }
    
    @objc func onDeadlineDateChanged(_ sender: UIDatePicker) {
        updateDeadlineDate(date: sender.date)
    }
    
    private func updateDeadlineDate(date: Date) {
        deadline = date
        deadlineDateLabel.text = dateToString(date: date)
        deadlineSwitcher.isOn = true
    }
    
    private func dateToString(date: Date, format: String = Values.deadlineDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    private func setDefaultDeadline(for date: Date = Date(), addingDays: Int = 1) {
        let deadlineDate = Calendar.current.date(byAdding: .day, value: addingDays, to: date) ?? Date()
        deadlineDatePicker.date = deadlineDate
        updateDeadlineDate(date: deadlineDate)
    }
    
    private func setDefaultPriority(_ priority: Priority = .medium) {
        switch priority {
        case .low:
            prioritySegmentedControl.selectedSegmentIndex = 0
            break
        case .medium:
            prioritySegmentedControl.selectedSegmentIndex = 1
            break
        case .high:
            prioritySegmentedControl.selectedSegmentIndex = 2
            break
        }
    }
    
    private func setDefaultValues() {
        if let currentTask = task {
            text = currentTask.text
            priority = currentTask.priority
            deadline = currentTask.deadline
        }
        
        descriptionView.text = text
        setDefaultPriority(priority)
        
        if let deadlineDate = deadline {
            setDefaultDeadline(for: deadlineDate, addingDays: 0)
        }
    }
    
    private func saveTask() {
        var savedTask: TodoItem
        text = descriptionView.text
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            priority = .low
            break
        case 1:
            priority = .medium
            break
        case 2:
            priority = .high
            break
        default:
            priority = .medium
            break
        }
        
        if let currentTask = task {
            savedTask = TodoItem(id: currentTask.id, text: text, priority: priority, deadline: deadline,
                                 isDone: task.isDone, createdOn: task.createdOn, updatedOn: Date())
        } else {
            savedTask = TodoItem(text: text, priority: priority, deadline: deadline)
        }
        
        fileCache.add(savedTask)
        
        do {
            try fileCache.save(name: "Test data", as: .json)
        } catch {
            print(error)
        }
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
