//
//  CheckControl.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

final class CheckControl: UIControl {

    // MARK: - Subviews

    private lazy var checkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private var circleImageRed = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkImageView.image = UIImage(named: "checkmark")
                checkImageView.tintColor = .systemGreen
            } else {
                checkImageView.image = UIImage(named: "circle")
                checkImageView.tintColor = circleImageRed ? .red : .gray
            }
        }
    }

    // MARK: - Init
    init(circleImageRed: Bool = false) {
        self.circleImageRed = circleImageRed
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    // MARK: - UI

    private func configureUI() {
        addSubview(checkImageView)
        checkImageView.image = UIImage(named: "circle")
        checkImageView.tintColor = .gray

        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: topAnchor),
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func changeCircleImageColorToRed(_ needsRed: Bool) {
        circleImageRed = needsRed
    }
}
