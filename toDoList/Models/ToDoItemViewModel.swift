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
    var importance: ToDoItemImportance?
    var deadLine: Date?
}
