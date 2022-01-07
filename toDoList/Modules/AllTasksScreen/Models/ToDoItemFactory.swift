//
//  ToDoItemFactory.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import Foundation

enum ToDoItemFactory {

    static func buildOneItem() -> [ToDoItem] {
        return [
            ToDoItem(
                id: "\(1)",
                text: String(repeating: "фытволыфраоытавфыолваыв", count: 10),
                importance: .usual,
                deadLine: Date()
            )
        ]
    }

    static func buildItems() -> [ToDoItem] {
        let range = 1...20
        return range.map { int in
            ToDoItem(
                id: "\(int)",
                text: String(repeating: "фытволыфраоытавфыолваыв", count: 10),
                importance: .usual,
                deadLine: Date()
            )
        }
    }
}
