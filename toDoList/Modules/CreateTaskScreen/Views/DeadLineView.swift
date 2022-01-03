//
//  DeadLineView.swift
//  toDoList
//
//  Created by User on 02.01.2022.
//

import UIKit

final class DeadLineView: UIView {

    // MARK: - Layout

    private enum Layout {

        enum TopLabel {
            static let text = "doTill".localised()
        }

        enum StackView {
            static let insets = UIEdgeInsets(top: 15, left: 16, bottom: -15, right: 0)
        }

        enum Switcher {
            static let trailingInset: CGFloat = -16
        }

        enum LineView {
            static let height: CGFloat = 1
            static let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }

        enum BelowLabel {
            static let fontSize: CGFloat = 13
        }
    }

    // MARK: - Subviews

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.TopLabel.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var belowLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: Layout.BelowLabel.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        return UISwitch()
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func configureUI() {
        backgroundColor = .white
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        switcher.translatesAutoresizingMaskIntoConstraints = false

        addSubview(switcher)
        addSubview(stackView)
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(belowLabel)
        addSubview(lineView)

    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.StackView.insets.left),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            switcher.centerYAnchor.constraint(equalTo: centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.Switcher.trailingInset),

            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.LineView.insets.left),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.LineView.insets.right),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Layout.LineView.height)
        ])
    }
}
