//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController {
    
    let taskTitle = "Дело"
    
    private let scrollView = UIScrollView()
    private let descriptionView = UITextView()
    private let descriptionPlaceholder = UILabel()
    
    private let deleteButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
        
        prepareNavigationBar()
        prepareContent()
    }
    
    private func prepareNavigationBar() {
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
        prepareScrollView()
        prepareDescriptionView()
        prepareDescriptionPlaceholder()
        prepareDeleteButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
        updatePlaceholderVisibility()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(deleteButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func prepareDescriptionView() {
        descriptionView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        descriptionView.tintColor = UIColor(named: AccentColors.backSecondary)
        descriptionView.layer.cornerRadius = Sizes.cornerRadius
        descriptionView.textColor = UIColor(named: AccentColors.labelPrimary)
        descriptionView.isScrollEnabled = false
        descriptionView.textContainerInset = UIEdgeInsets(top: Sizes.marginV, left: Sizes.marginH,
                                                          bottom: Sizes.marginH, right: Sizes.marginH)
        descriptionView.delegate = self
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            descriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            descriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Sizes.marginTxB),
            
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.textViewMinHeight),
            descriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
        
        descriptionView.clipsToBounds = true
        descriptionView.addSubview(descriptionPlaceholder)
    }
    
    private func prepareDescriptionPlaceholder() {
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
    
    private func prepareDeleteButton() {
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
            deleteButton.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: Sizes.marginTxB),
            
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
