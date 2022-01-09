//
//  UIImage+Images.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

extension UIImage {
    
    static var checkControl: UIImage {
        guard let image = UIImage(systemName: "checkmark.circle") else {
            return UIImage()
        }
        return image
    }
    
    static var checkMarkCircleFill: UIImage {
        guard let image = UIImage(systemName: "checkmark.circle.fill") else {
            return UIImage()
        }
        return image
    }
    
    static var infoCircleFill: UIImage {
        guard let image = UIImage(systemName: "info.circle.fill") else {
            return UIImage()
        }
        return image
    }
    
    static var trashFill: UIImage {
        guard let image = UIImage(systemName: "trash.fill") else {
            return UIImage()
        }
        return image
    }
}
