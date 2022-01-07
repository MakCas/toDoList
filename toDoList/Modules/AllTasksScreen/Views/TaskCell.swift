//
//  TaskCell.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

enum TypeCell {
    case first
    case withoutCorners
    case willAllCorners
    case last
}

final class TaskCell: UITableViewCell {


    // MARK: - Layout and Constants

    private enum Layout {

    }

    // MARK: - Subviews

    private lazy var checkControl: CheckControl = {
        let view = CheckControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "taskLabel"
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var deadLineLabel: UILabel = {
        let label = UILabel()
        //        label.text = "deadLineLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: - Properties

    private var typeCell: TypeCell?
    private var taskCellViewModel: TaskCellViewModel?


    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle


    // MARK: - UI

    private func configureUI() {
        accessoryType = .disclosureIndicator
        backgroundColor = .white
        layer.cornerRadius = 15

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(checkControl)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(taskLabel)
        stackView.addArrangedSubview(deadLineLabel)
    }

    private func addConstraints() {

        let heightConstraint = checkControl.heightAnchor.constraint(equalToConstant: 20)
        heightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            checkControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            heightConstraint,
            checkControl.widthAnchor.constraint(equalToConstant: 20),
            checkControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: checkControl.trailingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }

    // MARK: - Configure

    func configureCellWith(model: TaskCellViewModel, typeCell: TypeCell) {
        taskCellViewModel = model
        taskLabel.text = model.itemText
        deadLineLabel.text = model.deadLine

        switch typeCell {
        case .first:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .withoutCorners:
            layer.maskedCorners = []
        case .last:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .willAllCorners:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

    // MARK: - Functions

}
