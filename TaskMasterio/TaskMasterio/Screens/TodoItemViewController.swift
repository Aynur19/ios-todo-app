//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController, UITextViewDelegate {
    
    let taskTitle = "Дело"
    
    private var scrollView: UIScrollView?
    private var taskDescriptionView: UITextView?
    
    @IBOutlet private weak var taskDescriptionViewHeightConstraint: NSLayoutConstraint!
    
    private func updateTextViewHeight() {
        if let descriptionView = taskDescriptionView {
            let contentSize = descriptionView.sizeThatFits(descriptionView.bounds.size)
            let newSize = contentSize.height > Sizes.textViewMinHeight ? contentSize.height : Sizes.textViewMinHeight
            taskDescriptionViewHeightConstraint.constant = newSize
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateTextViewHeight()
        //            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: textViewHeightConstraint.constant)
        
    }
    
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
            
            let cancelButton = UIBarButtonItem(title: Titles.cancelButton, style: .plain, target: self,
                                               action: #selector(cancelButtonTapped))
            
            let saveButton = UIBarButtonItem(title: Titles.saveButton, style: .plain, target: self,
                                             action: #selector(saveButtonTapped))
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
    
    private func prepareContent() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        let taskDescriptionView = getTaskDescriptionView()
        scrollView.addSubview(taskDescriptionView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            taskDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Sizes.marginH),
            taskDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Sizes.marginH),
            taskDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Sizes.marginH),
            taskDescriptionView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -Sizes.marginH),
            
            taskDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Sizes.margin2xH),
        ])
        
        self.taskDescriptionView = taskDescriptionView
        self.scrollView = scrollView
        
    }
    
    private func getTaskDescriptionView() -> UITextView {
        let textView = UITextView()
        
        textView.font = UIFont.systemFont(ofSize: Sizes.textViewFontSize)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.text = "Что надо сделать?"
        textView.layer.cornerRadius = Sizes.textViewCornerRadius
        
        textView.textContainerInset = UIEdgeInsets(top: Sizes.marginV, left: Sizes.marginH,
                                                   bottom: Sizes.marginH, right: Sizes.marginH)
        
        textView.delegate = self
        
        let textViewHeightConstraint = textView.heightAnchor
            .constraint(equalToConstant: Sizes.textViewMinHeight)
            .with(priority: .defaultLow)
        textViewHeightConstraint.isActive = true
        
        self.taskDescriptionViewHeightConstraint = textViewHeightConstraint
        
        return textView
    }
}

