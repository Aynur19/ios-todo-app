//
//  TodoItem.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        setupContentScrollView()
        
        setupTapGestureRecognizer()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
    }
    
    private func setupNavBar() {
        if let navigationController = self.navigationController {
            navigationController.title = Titles.task
            navigationController.navigationBar.barStyle = .default
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    private func setupContentScrollView() {
        view.addSubview(contentScrollView)
        
        NSLayoutConstraint.activate([
            contentScrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            contentScrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentScrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = TodoItemScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(onCancelButtonTapped))
        
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(onSaveButtonTapped))
        button.isEnabled = false
        
        return button
    }()
    
    
    @objc private func onCancelButtonTapped() { }
    
    @objc private func onSaveButtonTapped() { }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
}
