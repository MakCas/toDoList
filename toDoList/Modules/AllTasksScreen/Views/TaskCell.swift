//
//  TaskCell.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

class TaskCell: UITableViewCell {

    // MARK: - Subviews

    private lazy var checkControl: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var deadLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: - Properties


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
        contentView.backgroundColor = .white
    }


    // MARK: - Configure

    func configureCell() {

    }

    // MARK: - Functions


    // MARK: - Layout and Constants

    private enum Layout {

    }
}
