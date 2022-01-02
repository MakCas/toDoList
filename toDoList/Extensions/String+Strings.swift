//
//  String+Strings.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

extension String {

    enum CreateTaskController {
        static let cancelButtonText = "Отменить"
        static let nameScreenLabelText = "Дело"
        static let saveButtonText = "Сохранить"

        enum ImportanceView {
            static let leftLabelText = "Важность"
            static let noText = "Нет"
            static let arrow = "↓"
            static let exclamationMark = "‼"
        }

        static let taskTextViewPlaceHolder = "Что надо сделать"
        static let deadLineLabelText = "Сложность до"
        static let deleteButtonText = "Удалить"
    }
}
