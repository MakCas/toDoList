//
//  TaskCellViewModel.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

struct TaskCellViewModel {
    
    var id: String
    var itemText: NSMutableAttributedString
    var itemImportance: ToDoItemImportance
    var deadLine: NSMutableAttributedString?
    var isDone: Bool
    
    // MARK: - Init
    
    init(from item: ToDoItem) {
        self.id = item.id
        self.itemImportance = item.importance
        isDone = item.isDone
        itemText = TaskCellViewModel.setItemText(from: item)
        
        guard let deadLine = item.deadLine else { return }
        let dateString = TaskCellViewModel.transferDateToString(from: deadLine)
        self.deadLine = TaskCellViewModel.transferStringToNSStringWithImage(for: dateString)
    }
    
    // MARK: - Helpers for Init
    
    private static func setItemText(from item: ToDoItem) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString(string: item.text)
        if item.isDone {
            fullString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: fullString.length))
        }
        return fullString
    }
    
    private static func transferDateToString(from date: Date) -> String {
        let formatter = DateFormatter.shared
        formatter.dateFormat = "d MMMM"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    private static func transferStringToNSStringWithImage(for string: String) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString(string: "")
        
        let imageCalendarAttachment = NSTextAttachment()
        imageCalendarAttachment.image = UIImage(named: "calendar")
        let imageString = NSAttributedString(attachment: imageCalendarAttachment)
        
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " " + string))
        
        return fullString
    }
}
