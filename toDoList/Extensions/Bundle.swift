//
//  Bundle+.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

extension Bundle {
    var appIcon: UIImage? {
        if let appIcons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryAppIcon = appIcons["CFBundlePrimaryIcon"] as? [String: Any],
           let appIconFiles = primaryAppIcon["CFBundleIconFiles"] as? [String],
           let lastAppIcon = appIconFiles.last {
            return UIImage(named: lastAppIcon)
        }
        return nil
    }
}
