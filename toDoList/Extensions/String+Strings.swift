//
//  String+Strings.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

extension String {

    enum CreateTaskController {

        enum TopStackView {
            static let cancelButtonText = "Отменить"
            static let nameScreenLabelText = "Дело"
            static let saveButtonText = "Сохранить"
        }

        enum ImportanceView {
            static let leftLabelText = "Важность"
            static let noText = "Нет"
            static let arrow = "↓"
            static let exclamationMark = "‼"
        }

        enum TaskTextView {
            static let placeHolder = "Что надо сделать?"
        }

        enum DeadLineView {
            static let topLabelText = "Сделать до"
        }

        static let deleteButtonText = "Удалить"
    }
}
