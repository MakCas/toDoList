//
//  UIColor+.swift
//  toDoList
//
//  Created by User on 02.01.2022.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        assert(red >= 0 && red <= 255, "Red digital is not ok")
        assert(green >= 0 && green <= 255, "Red digital is not ok")
        assert(blue >= 0 && blue <= 255, "Red digital is not ok")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    static var backGroundColor: UIColor {
        return UIColor(red: 245, green: 244, blue: 238)
    }

    static var textViewPlaceHolderColor: UIColor {
        return UIColor(red: 200, green: 200, blue: 200)
    }
}
