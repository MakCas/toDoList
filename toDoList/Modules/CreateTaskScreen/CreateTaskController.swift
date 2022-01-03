//
//  CreateTaskController.swift
//  toDoList
//
//  Created by User on 31.12.2021.
//

import UIKit

final class CreateTaskController: UIViewController {

    // MARK: - Layout

    enum Layout {

        static let fontSize: CGFloat = 18

        enum TopStackView {
            static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            static let height: CGFloat = 50
            static let minimumLineSpacing: CGFloat = 10

            static let cancelButtonTextKey = "cancelButtonText".localised()
            static let nameScreenLabelTextKey = "nameScreenLabelText".localised()
            static let saveButtonTextKey = "saveButtonText".localised()
        }

        enum BigStackView {
            static let insets = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: -16)
            static let minimumLineSpacing: CGFloat = 15
        }

        enum TextView {
            static let height: CGFloat = 120
        }

        enum DeleteButton {
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 60
            static let title = "delete".localised()
        }

        enum ContainerForSmallStackView {
            static let cornerRadius: CGFloat = 16
        }
    }

    // MARK: - Subviews

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.TopStackView.cancelButtonTextKey, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameScreenLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.TopStackView.nameScreenLabelTextKey
        label.font = UIFont.systemFont(ofSize: Layout.fontSize, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.TopStackView.saveButtonTextKey, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Layout.fontSize, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var bigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Layout.BigStackView.minimumLineSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var taskTextView: TextViewWithPlaceholder = {
        let textView = TextViewWithPlaceholder()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var containerForSmallStackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.ContainerForSmallStackView.cornerRadius
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var smallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var importanceView: ImportanceView = {
        let view = ImportanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var deadLineView: DeadLineView = {
        let view = DeadLineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var calendarView: CalendarView = {
        let view = CalendarView(baseDate: Date()) { date in
            printDebug(date)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.DeleteButton.title, for: .normal)
        button.isEnabled = true
        button.layer.cornerRadius = Layout.DeleteButton.cornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - UI

    private func configureUI() {
        view.backgroundColor = .backGroundColor

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(cancelButton)
        topStackView.addArrangedSubview(nameScreenLabel)
        topStackView.addArrangedSubview(saveButton)

        view.addSubview(bigStackView)
        bigStackView.addArrangedSubview(taskTextView)

        bigStackView.addArrangedSubview(containerForSmallStackView)
        containerForSmallStackView.addSubview(smallStackView)
        smallStackView.addArrangedSubview(importanceView)
        smallStackView.addArrangedSubview(deadLineView)
        smallStackView.addArrangedSubview(calendarView)

        bigStackView.addArrangedSubview(deleteButton)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.TopStackView.insets.left),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.TopStackView.insets.right),
            topStackView.heightAnchor.constraint(equalToConstant: Layout.TopStackView.height),

            bigStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: Layout.BigStackView.insets.top),
            bigStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.BigStackView.insets.left),
            bigStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.BigStackView.insets.right),

            taskTextView.heightAnchor.constraint(equalToConstant: Layout.TextView.height),

            smallStackView.topAnchor.constraint(equalTo: containerForSmallStackView.topAnchor),
            smallStackView.leadingAnchor.constraint(equalTo: containerForSmallStackView.leadingAnchor),
            smallStackView.trailingAnchor.constraint(equalTo: containerForSmallStackView.trailingAnchor),
            smallStackView.bottomAnchor.constraint(equalTo: containerForSmallStackView.bottomAnchor),

            //            calendarView.heightAnchor.constraint(equalToConstant: 250),

            deleteButton.heightAnchor.constraint(equalToConstant: Layout.DeleteButton.height)
        ])
    }
}
