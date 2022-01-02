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

        enum TopStackView {
            static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            static let height: CGFloat = 50
            static let minimumLineSpacing: CGFloat = 10
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
        button.setTitle(.CreateTaskController.TopStackView.cancelButtonText, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nameScreenLabel: UILabel = {
        let label = UILabel()
        label.text = .CreateTaskController.TopStackView.nameScreenLabelText
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(.CreateTaskController.TopStackView.saveButtonText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var bigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var taskTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var containerForSmallStackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var smallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var importanceView: ImportanceView = {
        let view = ImportanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var deadLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var calendarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
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
            topStackView.heightAnchor.constraint(equalToConstant: Layout.TopStackView.height)
        ])
    }
}
