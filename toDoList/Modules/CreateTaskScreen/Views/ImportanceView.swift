//
//  ImportanceView.swift
//  toDoList
//
//  Created by User on 02.01.2022.
//

import UIKit

protocol ImportanceViewDelegate: AnyObject {

}

final class ImportanceView: UIView {
    
    // MARK: - Layout
    
    private enum Layout {
        
        enum ImportanceLabel {
            static let leadingInset: CGFloat = 16
            static let text = "importance".localised()
        }
        
        enum SegmentControl {
            static let insets = UIEdgeInsets(top: 13, left: 0, bottom: -13, right: -16)
            static let arrow = "↓"
            static let noText = "noText".localised()
            static let exclamationMark = "‼"
        }
        
        enum LineView {
            static let height: CGFloat = 1
            static let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }
    }
    
    // MARK: - Subviews
    
    private lazy var importanceLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.ImportanceLabel.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(
            items: [
                Layout.SegmentControl.arrow,
                Layout.SegmentControl.noText,
                Layout.SegmentControl.exclamationMark
            ]
        )
        segmentControl.selectedSegmentIndex = 2
        segmentControl.addTarget(self, action: #selector(segmentControlTapped(sender:)), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    weak var delegate: ImportanceViewDelegate?
    
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
        addSubview(importanceLabel)
        addSubview(segmentControl)
        addSubview(lineView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([

            importanceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            importanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.ImportanceLabel.leadingInset),

            segmentControl.topAnchor.constraint(equalTo: topAnchor, constant: Layout.SegmentControl.insets.top),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.SegmentControl.insets.right),
            segmentControl.widthAnchor.constraint(equalToConstant: 150),
            segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Layout.SegmentControl.insets.bottom),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Layout.LineView.height),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.LineView.insets.left),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.LineView.insets.right)
        ])
    }
    
    // MARK: - Functions
    
    @objc private func segmentControlTapped(sender: UISegmentedControl) {
        let segmentControlIndex = sender.selectedSegmentIndex
        printDebug(segmentControlIndex)
    }
}
