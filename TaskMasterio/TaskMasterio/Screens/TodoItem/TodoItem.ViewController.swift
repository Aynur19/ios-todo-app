//
//  TodoItem.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit
import Combine

final class TodoItemViewController2: UIViewController {
    
    var viewModel: TodoItemViewModel!
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        setupContentScrollView()
        
        setupTapGestureRecognizer()
        
        configure()
    }
    
    // MARK: - Setup Functions
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
            contentScrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Sizes.margin_16),
        ])
        contentScrollView.contentSize = view.bounds.size
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configure() {
//        contentScrollView.configure(with: viewModel)
        
        viewModel.taskIsChanged
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var contentScrollView = TodoItemScrollView(with: viewModel)
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(onCancelButtonTapped))
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(onSaveButtonTapped))
        button.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.getFont(named: .bodyBold)], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.getFont(named: .bodyBold)], for: .disabled)
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Handlers
    @objc private func onCancelButtonTapped() { }
    
    @objc private func onSaveButtonTapped() {
        viewModel.saveTask()
    }
    
    @objc private func onViewTapped() {
        view.endEditing(true)
    }
}
