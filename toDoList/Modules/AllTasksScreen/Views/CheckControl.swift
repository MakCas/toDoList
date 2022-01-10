//
//  CheckControl.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

final class CheckControl: BigAreaControl {
    
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
                checkImageView.image = .checkMark
                checkImageView.tintColor = .systemGreen
            } else {
                checkImageView.image = .circle
                checkImageView.tintColor = circleImageRed ? .systemRed : .systemGray3
            }
        }
    }
    
    // MARK: - Init

    init(circleImageRed: Bool = false, xInset: CGFloat = 0, yInset: CGFloat = 0) {
        self.circleImageRed = circleImageRed
        super.init(xInset: xInset, yInset: xInset)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - UI
    
    private func configureUI() {
        addSubview(checkImageView)
        checkImageView.image = .circle
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
