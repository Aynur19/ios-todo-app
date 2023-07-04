//
//  TodoItemViewController.ViewBuilder.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 23.06.2023.
//


import UIKit

extension TodoItemViewController {
    func buildContentScrollView(_ scrollView: UIScrollView) -> UIScrollView {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    func buildContentStackView(_ stackView: UIStackView) -> UIStackView {
        stackView.axis = .vertical
        stackView.spacing = Margins.mg16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func buildDescriptionView(_ textView: UITextView) -> UITextView {
        textView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.layer.cornerRadius = Sizes.cornerRadius
        textView.textColor = UIColor(named: AccentColors.labelPrimary)
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: Margins.mg12, left: Margins.mg16,
                                                   bottom: Margins.mg16, right: Margins.mg16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
    
    func buildDescriptionPlaceholder(_ label: UILabel) -> UILabel {
        label.tintColor = UIColor(named: AccentColors.backSecondary)
        label.text = Values.taskDescriptionPlacholder
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func buildOptionsStackView(_ stackView: UIStackView) -> UIStackView {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = UIColor(named: AccentColors.backSecondary)
        stackView.layer.cornerRadius = Sizes.cornerRadius
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func buildPriorityContainer(_ container: UIView) -> UIView {
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }
    
    func buildPriorityStackView(_ stackView: UIStackView) -> UIStackView {
        stackView.axis = .horizontal
        stackView.spacing = Margins.mg16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func buildPriorityLabel(_ label: UILabel) -> UILabel {
        label.text = Titles.priority
        label.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func buildPrioritySegmentedControl(_ segmentedControl: UISegmentedControl) -> UISegmentedControl {
        let low = UIImage(named: Priority.low.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorGrey) ?? .gray, renderingMode: .alwaysOriginal)
        let high = UIImage(named: Priority.high.rawValue)?
            .withTintColor(UIColor(named: AccentColors.colorRed) ?? .red, renderingMode: .alwaysOriginal)
        
        segmentedControl.insertSegment(with: low, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: Values.priorityMedium, at: 1, animated: false)
        segmentedControl.insertSegment(with: high, at: 2, animated: false)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.sfPro_15], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.sfPro_15], for: .selected)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .disabled)
        
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor(named: AccentColors.labelPrimary) ?? .label], for: .selected)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }
    
    func buildOptionsStackSeparator(_ separator: UIView) -> UIView {
        separator.backgroundColor = UIColor(named: AccentColors.supportSeparator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }
    
    func buildDeadlineContainer(_ container: UIView) -> UIView {
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }
    
    func buildDeadlineStackView(_ stackView: UIStackView) -> UIStackView {
        stackView.axis = .horizontal
        stackView.spacing = Margins.mg16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    func buildDeadlineLabelContainer(_ container: UIView) -> UIView {
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }
    
    func buildDeadlineLabel(_ label: UILabel) -> UILabel {
        label.text = Titles.deadline
        label.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        label.textColor = UIColor(named: AccentColors.labelPrimary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func buildDeadlineDateLabel(_ label: UILabel) -> UILabel {
        label.text = ""
        label.font = Fonts.sfPro_13
        label.textColor = UIColor(named: AccentColors.colorBlue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func buildDeadlineSwitcher(_ switcher: UISwitch) -> UISwitch {
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.tintColor = UIColor(named: AccentColors.labelPrimary)
        return switcher
    }
    
    func buildDeadlineCalendarSeparator(_ separator: UIView) -> UIView {
        separator.backgroundColor = UIColor(named: AccentColors.supportSeparator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.isHidden = true
        
        return separator
    }
    
    func buildDeadlineDatePicker(_ datePicker: UIDatePicker) -> UIDatePicker {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.isHidden = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datePicker
    }
    
    func buildDeleteButton(_ button: UIButton) -> UIButton {
        button.setTitle(Titles.delete, for: .normal)
        button.backgroundColor = UIColor(named: AccentColors.backSecondary)
        button.setTitleColor(UIColor(named: AccentColors.colorRed), for: .normal)
        button.setTitleColor(UIColor(named: AccentColors.labelTertiary), for: .disabled)
        button.layer.cornerRadius = Sizes.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
