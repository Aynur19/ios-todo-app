//
//  TodoItem.ScrollView.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit

final class TodoItemScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDescriptionView()
//        setupKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupDescriptionView()
//        setupKeyboardObservers()
    }
    
//    private func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        // Adjust the scroll view's content inset and scroll indicator insets to accommodate the keyboard
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
//            return
//        }
//        // Calculate the visible content area by subtracting the keyboard height
//                let visibleContentHeight = self.frame.height - keyboardFrame.height
//
//                // Update the content size to include the visible area
//                self.contentSize.height = visibleContentHeight
        
//        scrollRectToVisible(<#T##rect: CGRect##CGRect#>, animated: <#T##Bool#>)
//        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//        self.contentInset = contentInsets
//        self.scrollIndicatorInsets = contentInsets
//
//        // Determine the currently active text view (if any)
//        var activeTextView: UITextView?
//        for view in self.subviews {
//            if let textView = view as? UITextView, textView.isFirstResponder {
//                activeTextView = textView
//                break
//            }
//        }
//
//        // Scroll the content to ensure the active text view is visible
//        if let textView = activeTextView {
//            var contentOffset = self.contentOffset
//            contentOffset.y += textView.frame.origin.y - contentInset.top - 8 // Adjust the offset as needed
//            self.setContentOffset(contentOffset, animated: true)
//        }
//    }
    
//    @objc private func keyboardWillHide(_ notification: Notification) {
        // Reset the scroll view's content inset and scroll indicator insets when the keyboard is hidden
//        self.contentSize = self.bounds.size
//        self.contentInset = .zero
//        self.scrollIndicatorInsets = .zero
//    }
    
    private func setupDescriptionView() {
        addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            descriptionView.heightAnchor.constraint(greaterThanOrEqualToConstant: Sizes.descriptionMinHeight),
        ])
    }
    
    private lazy var descriptionView: UITextView = {
        let textView = TodoItemDescriptionView(frame: .zero)
        textView.font = Fonts.getFont(named: .body)
        textView.tintColor = UIColor(named: AccentColors.backSecondary)
        textView.layer.cornerRadius = Sizes.cornerRadius
        textView.textColor = UIColor(named: AccentColors.labelPrimary)
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: Sizes.margin_12, left: Sizes.margin_16,
                                                   bottom: Sizes.margin_12, right: Sizes.margin_16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
}
    
//    private func setupContentStackView() {
//        addSubview(contentStackView)
//
//        NSLayoutConstraint.activate([
//            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Sizes.margin2xH),
//            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.spacingV),
//            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Sizes.spacingV),
//        ])
//    }
//
//    private lazy var contentStackView: UIStackView = {
//        let stackView = TodoItemContentStackView(frame: .zero)
//        stackView.axis = .vertical
//        stackView.spacing = Sizes.spacingV
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        return stackView
//    }()
//}
