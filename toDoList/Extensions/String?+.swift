//
//  String?+.swift
//  toDoList
//
//  Created by User on 02.01.2022.
//

import Foundation

extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        return self == nil || self?.isEmpty == true
    }
}
