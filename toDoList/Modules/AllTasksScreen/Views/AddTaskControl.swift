//
//  AddTaskControl.swift
//  toDoList
//
//  Created by User on 07.01.2022.
//

import Foundation

import UIKit

final class AddTaskControl: UIControl {

    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
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
        addSubview(imageView)
        imageView.image = UIImage(named: "plusButton")
        imageView.tintColor = .systemBlue

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
