//
//  String+Strings.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

extension String {

    func localised() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
