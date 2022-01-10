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

    case withTopMaskedCorners
    case withoutMaskedCorners
    case willAllMaskedCorners
    case withBottomMaskedCorners
}

// MARK: - Class

final class TaskCell: UITableViewCell {

    // MARK: - Layout and Constants

    private enum Layout {

        enum ContentView {
            static let cornerRadius: CGFloat = 15
        }

        enum StackView {
            static let spacing: CGFloat = 0
            static let insets = UIEdgeInsets(top: 15, left: 10, bottom: -15, right: -10)
        }

        enum TaskLabel {
            static let numberOfLines = 3
        }

        enum CheckControl {
            static let leadingInset: CGFloat = 15
            static let size: CGFloat = 30
        }

        enum ChevronImageView {
            static let trailingInset: CGFloat = -15
        }

        enum LinveView {
            static let height: CGFloat = 1
        }

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
        stackView.spacing = Layout.StackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Layout.TaskLabel.numberOfLines
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
        imageView.image = .chevronRight
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

    weak var delegate: TaskCellDelegate?

    private var taskCellViewModel: TaskCellViewModel?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = Layout.ContentView.cornerRadius

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

        let heightConstraint = checkControl.heightAnchor.constraint(equalToConstant: Layout.CheckControl.size)
        heightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            checkControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.CheckControl.leadingInset),
            heightConstraint,
            checkControl.widthAnchor.constraint(equalToConstant: Layout.CheckControl.size),
            checkControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Layout.ChevronImageView.trailingInset),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.StackView.insets.top),
            stackView.leadingAnchor.constraint(equalTo: checkControl.trailingAnchor, constant: Layout.StackView.insets.left),
            stackView.trailingAnchor.constraint(equalTo: chevronImageView.trailingAnchor, constant: Layout.StackView.insets.right),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Layout.StackView.insets.bottom),

            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Layout.LinveView.height)

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
        setMaskedCornersAndSeparator(for: typeCell)
    }

    // MARK: - Private Functions

    private func setMaskedCornersAndSeparator(for typeCell: TypeCell) {
        lineView.isHidden = false
        switch typeCell {
        case .withTopMaskedCorners:
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .withoutMaskedCorners:
            contentView.layer.maskedCorners = []
        case .withBottomMaskedCorners:
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            lineView.isHidden = true
        case .willAllMaskedCorners:
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            lineView.isHidden = true
        }
    }

    @objc private func controlTapped(sender: UIControl) {
        guard let model = taskCellViewModel else { return }
        delegate?.statusChangedFor(taskID: model.id)
    }
}
