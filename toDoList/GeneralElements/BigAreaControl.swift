//
//  BigAreaControl.swift
//  toDoList
//
//  Created by User on 08.01.2022.
//

import UIKit

class BigAreaControl: UIControl {

    // MARK: - Layout

    private enum Layout {
        static let minTapArea: CGFloat = 44
    }

    // MARK: - Properties

    var xInset: CGFloat
    var yInset: CGFloat

    // MARK: - Init

    init(xInset: CGFloat = 0, yInset: CGFloat = 0) {
        self.xInset = xInset
        self.yInset = yInset
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        xInset = 0
        yInset = 0
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if xInset == 0 && yInset == 0 {
            if (Layout.minTapArea - bounds.width) > 0 {
                xInset = Layout.minTapArea - bounds.width
            }

            if (Layout.minTapArea - bounds.height) > 0 {
                yInset = Layout.minTapArea - bounds.width
            }
            return bounds.insetBy(dx: -xInset, dy: -yInset).contains(point)
        } else {
            return bounds.insetBy(dx: -xInset, dy: -yInset).contains(point)
        }
    }
}
