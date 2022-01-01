//
//  UIImage+Images.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

extension UIImage {

    enum ViewController {
        static var appIcon: UIImage {
            guard let image = Bundle.main.appIcon else {
                return UIImage()
            }
            return image
        }
    }
}
