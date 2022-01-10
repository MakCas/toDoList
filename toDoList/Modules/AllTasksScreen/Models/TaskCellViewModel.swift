//
//  TaskCellViewModel.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

struct TaskCellViewModel {

    let id: String
    var itemText: NSMutableAttributedString
    var itemImportance: ToDoItemImportance
    var deadLineWithCalendar: NSMutableAttributedString?
    var isDone: Bool {
        didSet {
            itemText = TaskCellViewModel.getStrikeThroughTextIfNeeded(for: itemText, isDone: isDone)
        }
    }

    // MARK: - Init

    init(from item: ToDoItem) {
        self.id = item.id
        self.itemImportance = item.importance
        self.isDone = item.isDone

        let textMutableString = TaskCellViewModel.getImportantTextIfNeeded(for: item.text, importance: item.importance)
        itemText = TaskCellViewModel.getStrikeThroughTextIfNeeded(for: textMutableString, isDone: item.isDone)

        guard let deadLine = item.deadLine else { return }
        let dateString = TaskCellViewModel.transferDateToString(from: deadLine)
        self.deadLineWithCalendar = TaskCellViewModel.addCalendarImage(for: dateString)
    }

    // MARK: - Helpers for Init

    private static func getImportantTextIfNeeded(for text: String, importance: ToDoItemImportance) -> NSMutableAttributedString {
        let fullTextString: NSMutableAttributedString = NSMutableAttributedString(string: "")
        let taskTextMutableString = NSMutableAttributedString(string: text)
        if importance == .important {
            let exclamationString = NSMutableAttributedString(string: "!!")
            exclamationString.addAttributes([.foregroundColor: UIColor.red], range: NSRange(location: 0, length: exclamationString.length))
            fullTextString.append(exclamationString)
        }
        fullTextString.append(taskTextMutableString)
        return fullTextString
    }
    
    private static func getStrikeThroughTextIfNeeded(for string: NSMutableAttributedString, isDone: Bool) -> NSMutableAttributedString {
        if isDone {
            string.addAttributes(
                [
                    .foregroundColor: UIColor.systemGray,
                    .strikethroughStyle: 1
                ],
                range: NSRange(location: 0, length: string.length)
            )
        } else {
            string.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: string.length))
        }
        return string
    }

    private static func transferDateToString(from date: Date) -> String {
        let formatter = DateFormatter.shared
        formatter.dateFormat = "d MMMM"
        let dateString = formatter.string(from: date)
        return dateString
    }

    private static func addCalendarImage(for string: String) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString(string: "")

        let imageCalendarAttachment = NSTextAttachment()
        imageCalendarAttachment.image = UIImage(named: "calendar")?.withTintColor(.systemGray)
        let imageString = NSAttributedString(attachment: imageCalendarAttachment)

        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " " + string))

        fullString.addAttributes(
            [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.systemGray
            ],
            range: NSRange(location: 0, length: fullString.length)
        )

        return fullString
    }
}
