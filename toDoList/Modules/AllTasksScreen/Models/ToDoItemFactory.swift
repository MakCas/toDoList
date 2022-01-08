//
//  ToDoItemFactory.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import Foundation

enum ToDoItemFactory {

    private var date: String {
        return "15.01.2022"
    }

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
        let range = 1...7
        DateFormatter.shared.dateFormat = "dd.mm.yyyy"

        return range.map { int in
            ToDoItem(
                id: "\(int)",
                text: String(repeating: "фыт", count: 1),
                importance: .usual,
                deadLine: DateFormatter.shared.date(from: "1\(int).01.2022")
            )
        }
    }
}
