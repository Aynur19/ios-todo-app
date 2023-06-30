//
//  TodoList.TableViewCell.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var subtitleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
        //        titleLabel = UILabel()
        //        subtitleLabel = UILabel()
        //
        //        contentView.addSubview(titleLabel)
        //        contentView.addSubview(subtitleLabel)
        
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    ////
    ////        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 20)
    ////        subtitleLabel.frame = CGRect(x: 10, y: 30, width: contentView.bounds.width - 20, height: 20)
    //    }
    
    // MARK: - Setup Functions
    private func setup() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(completionMark)
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Margins._2x16),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins._16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins._16),
            
            completionMark.heightAnchor.constraint(equalToConstant: 24),
            completionMark.widthAnchor.constraint(equalToConstant: 24),
            completionMark.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
        
        
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Sizes.margin_16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var completionMark: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Mark. Off")
        button.setImage(image, for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
}
