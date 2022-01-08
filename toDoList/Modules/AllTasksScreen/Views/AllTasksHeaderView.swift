//
//  AllTasksHeaderView.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

protocol AllTasksHeaderViewDelegate: AnyObject {
    
    func showDoneTasksButton(isSelected: Bool)
}

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
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showHideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать", for: .normal)
        button.setTitle("Скрыть", for: .selected)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 17, weight: .semibold)
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

    override func layoutSubviews() {
       super.layoutSubviews()
       subviews.filter { $0 != contentView && $0.frame.width == frame.width }.first?.removeFromSuperview()
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
    
    // MARK: - Public Functions
    
    @objc private func showHideButtonTapped(sender: UIButton) {
        delegate?.showDoneTasksButton(isSelected: !sender.isSelected)
    }
    
    func setNumberDoneTasks(_ number: Int) {
        doneLabel.text = "Выполнено - \(number)"
    }
    
    func changeHideDoneTasksStatus(for isSelected: Bool) {
        showHideButton.isSelected = isSelected
    }
}
