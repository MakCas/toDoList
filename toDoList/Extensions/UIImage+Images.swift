//
//  UIImage+Images.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

extension UIImage {

    enum AllTasksController {
        static var checkControl: UIImage {
            guard let image = UIImage(systemName: "checkmark.circle") else {
                return UIImage()
            }
            return image
        }
    }
}
