//
//  String+Strings.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

extension String {

    enum ViewController {
        static let appVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
