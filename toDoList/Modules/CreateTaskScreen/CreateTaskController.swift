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

    }

    // MARK: - Subviews

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private lazy var nameScreenLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private lazy var bigStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private lazy var taskTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    private lazy var containerForSmallStackView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var smallStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private lazy var importanceView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var deadLineView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var calendarView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - UI

    private func configureUI() {
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
        ])
    }
}
