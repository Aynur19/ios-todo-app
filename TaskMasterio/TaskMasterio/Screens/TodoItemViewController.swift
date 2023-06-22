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

            taskDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            taskDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            taskDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            taskDescriptionView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -16),
          
            taskDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            taskDescriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).with(priority: .defaultLow),
        ])
        
        //taskDescriptionView.addObserver(self, forKeyPath: "text", options: .new, context: nil)

        self.taskDescriptionView = taskDescriptionView
        self.scrollView = scrollView
        
    }
    
    private func getTaskDescriptionView() -> UITextView {
        let textView = UITextView()
        
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.text = "Что надо сделать?"
        textView.delegate = self
        
        return textView
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?,
//                               context: UnsafeMutableRawPointer?) {
//        if keyPath == "text", let textView = object as? UITextView {
//            let contentSize = textView.contentSize
//            let newHeight = contentSize.height > 120 ? contentSize.height : 120 // Minimum height
//
////            taskDescriptionView.heightAnchor.constraint(equalToConstant: newHeight)
//            scrollView.layoutIfNeeded()
//        }
//    }

}

