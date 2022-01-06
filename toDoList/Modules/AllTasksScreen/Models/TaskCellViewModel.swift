//
//  TaskCellViewModel.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

struct TaskCellViewModel {
    var id: String
    var itemText: String
    var itemImportance: ToDoItemImportance
    var deadLine: String?

    init(from item: ToDoItem) {
        self.id = item.id
        self.itemText = item.text
        self.itemImportance = item.importance
        guard let deadLine = item.deadLine else { return }
        self.deadLine = transferDateToString(from: deadLine)
    }

    private func transferDateToString(from date: Date) -> String {
        let formatter = DateFormatter.shared
        formatter.dateFormat = "d MMMM"
        let dateString = formatter.string(from: date)
        return dateString
    }
}
