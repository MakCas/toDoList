//
//  ToDoItemViewModel.swift
//  toDoList
//
//  Created by User on 04.01.2022.
//

import Foundation

struct ToDoItemViewModel {
    
    var id: String?
    var text: String?
    var importance: ToDoItemImportance = .usual
    var deadLine: Date?
    
    init(from toDoItem: ToDoItem) {
        self.id = toDoItem.id
        self.text = toDoItem.text
        self.importance = toDoItem.importance
        self.deadLine = toDoItem.deadLine
    }
    
    init() {
        self.id = nil
        self.text = nil
        self.deadLine = nil
    }
}
