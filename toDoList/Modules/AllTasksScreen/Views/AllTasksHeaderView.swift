//
//  AllTasksHeaderView.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

// MARK: - Protocol

protocol AllTasksHeaderViewDelegate: AnyObject {
    
    func showDoneTasksButton(isSelected: Bool)
}

// MARK: - Class

final class AllTasksHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Layout
    
    enum Layout {
        
        enum ShowHideButton {
            static let fontSize: CGFloat = 17
            static let trailingInset: CGFloat = -15
            static let textForNormalKey = "allTasksHeaderViewShow".localised()
            static let textForSelectedKey = "allTasksHeaderViewHide".localised()
        }
        
        enum DoneLabel {
            static let leadingInset: CGFloat = 15
            static let textKey = "allTasksHeaderViewDone".localised()
        }
    }
    
    // MARK: - Subviews
    
    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.ShowHideButton.textForNormalKey, for: .normal)
        button.setTitle(Layout.ShowHideButton.textForSelectedKey, for: .selected)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: Layout.ShowHideButton.fontSize, weight: .semibold)
        button.addTarget(self, action: #selector(showHideButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: AllTasksHeaderViewDelegate?
    
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
        backgroundView?.backgroundColor = .clear
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
            doneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.DoneLabel.leadingInset),
            
            showHideButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.ShowHideButton.trailingInset)
        ])
    }
    
    // MARK: - Public Functions
    
    @objc private func showHideButtonTapped(sender: UIButton) {
        delegate?.showDoneTasksButton(isSelected: !sender.isSelected)
    }
    
    func setNumberDoneTasks(_ number: Int) {
        doneLabel.text = Layout.DoneLabel.textKey + "\(number)"
    }
    
    func changeHideDoneTasksStatus(for isSelected: Bool) {
        showHideButton.isSelected = isSelected
    }
}
