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

    static var plusCircleFill: UIImage {
        guard let image = UIImage(systemName: "plus.circle.fill") else {
            return UIImage()
        }
        return image
    }

    static var chevronRight: UIImage {
        guard let image = UIImage(systemName: "chevron.right") else {
            return UIImage()
        }
        return image
    }

    static var checkMark: UIImage {
        guard let image = UIImage(named: "checkmark") else {
            return UIImage()
        }
        return image
    }

    static var circle: UIImage {
        guard let image = UIImage(named: "circle") else {
            return UIImage()
        }
        return image
    }
}
