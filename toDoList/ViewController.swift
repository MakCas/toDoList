//
//  ViewController.swift
//  toDoList
//
//  Created by User on 31.12.2021.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Layout

    enum Layout {

        enum IconImageView {
            static let topInset: CGFloat = 10
            static let size: CGFloat = 100
        }

        enum AppVersionLabel {
            static let topInset: CGFloat = 25
        }
    }

    // MARK: - Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .ViewController.appIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.text = .ViewController.appVersion
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - UI

    private func configureUI() {
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(iconImageView)
        view.addSubview(appVersionLabel)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.IconImageView.topInset),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Layout.IconImageView.size),
            iconImageView.heightAnchor.constraint(equalToConstant: Layout.IconImageView.size),

            appVersionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Layout.AppVersionLabel.topInset),
            appVersionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
