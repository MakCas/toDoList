//
//  TaskCell.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

protocol TaskCellDelegate: AnyObject {

    func statusChangedFor(taskID: String)
}

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
        let control = CheckControl()
        control.addTarget(self, action: #selector(controlTapped(sender:)), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private var typeCell: TypeCell?
    private var taskCellViewModel: TaskCellViewModel?
    weak var delegate: TaskCellDelegate?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        let width = subviews[0].frame.width
    //
    //        for view in subviews where view != contentView {
    //            if typeCell == .first || typeCell == .last  {
    //            if view.frame.width == width {
    //                view.removeFromSuperview()
    //                }
    //            }
    //        }
    //    }

    // MARK: - UI

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(checkControl)
        contentView.addSubview(stackView)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(lineView)
        stackView.addArrangedSubview(taskLabel)
        stackView.addArrangedSubview(deadLineLabel)
    }

    private func addConstraints() {

        let heightConstraint = checkControl.heightAnchor.constraint(equalToConstant: 30)
        heightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            checkControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            heightConstraint,
            checkControl.widthAnchor.constraint(equalToConstant: 30),
            checkControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: checkControl.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: chevronImageView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),


            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)

        ])
    }

    // MARK: - Configure

    func configureCellWith(model: TaskCellViewModel, typeCell: TypeCell) {
        taskCellViewModel = model
        taskLabel.attributedText = model.itemText
        deadLineLabel.attributedText = model.deadLineWithCalendar
        if model.itemImportance == .important {
            checkControl.changeCircleImageColorToRed(true)
        } else {
            checkControl.changeCircleImageColorToRed(false)
        }
        checkControl.isSelected = model.isDone
        self.typeCell = typeCell
        setMaskedCornersAndSeparator(for: typeCell)

    }

    // MARK: - Private Functions

    private func setMaskedCornersAndSeparator(for typeCell: TypeCell) {
        lineView.isHidden = false
        switch typeCell {
        case .first:
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .withoutCorners:
            contentView.layer.maskedCorners = []
        case .last:
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            lineView.isHidden = true
        case .willAllCorners:
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            lineView.isHidden = true
        }
    }

    @objc private func controlTapped(sender: UIControl) {
        guard let model = taskCellViewModel else { return }
        delegate?.statusChangedFor(taskID: model.id)
    }
}
