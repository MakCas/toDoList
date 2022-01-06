//
//  AllTasksHeaderView.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

class AllTasksHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Layout
    
    enum Layout {
        
        enum Example {
            static let top: CGFloat = 1
        }
    }
    
    // MARK: - Subviews
    
    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.text = "TestLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("TestButton", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func configureUI() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(doneLabel)
        addSubview(showHideButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            doneLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            doneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            showHideButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
