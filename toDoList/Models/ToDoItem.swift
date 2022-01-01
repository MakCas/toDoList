//
//  ToDoItem.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

enum ToDoItemImportanceEnum: String {

    case notImportant
    case usual
    case important
}

// MARK: - Struct

struct ToDoItem {

    // MARK: - Properties

    let id: String
    let text: String
    let importance: ToDoItemImportanceEnum
    let deadLine: Date?

    // MARK: - Init

    init(
        id: String = UUID().uuidString,
        text: String,
        importance: ToDoItemImportanceEnum?,
        deadLine: Date? = nil
    ) {
        self.id = id
        self.text = text
        if let importance = importance {
            self.importance = importance
        } else {
            self.importance = .usual
        }
        self.deadLine = deadLine
    }
}

// MARK: - Extension

extension ToDoItem {

    var json: Any? {
        var toDoItemDictionary: [String: Any] = [
            "id": self.id as Any,
            "text": self.text as Any
        ]

        if self.importance != .usual {
            toDoItemDictionary["importance"] = self.importance.rawValue as Any
        }

        if let deadLine = self.deadLine?.timeIntervalSince1970 {
            toDoItemDictionary["deadLine"] = deadLine as Any
        }

        do {
            let json = try JSONSerialization.data(withJSONObject: toDoItemDictionary, options: .fragmentsAllowed)
            return json
        } catch {
            return nil
        }
    }

    static func parse(json: Any) -> ToDoItem? {
        let toDoItemJson = json as? [String: Any]
        guard let toDoItemJson = toDoItemJson else { return nil }
        let id = toDoItemJson["id"] as? String
        let text = toDoItemJson["text"] as? String
        let importance = toDoItemJson["importance"] as? String
        let deadLine = toDoItemJson["deadLine"] as? Double

        guard
            let id = id,
            let text = text
        else {
            return nil
        }
        
        var deadLineDate: Date?
        if let deadLine = deadLine {
            deadLineDate = Date(timeIntervalSince1970: deadLine)
        }

        var importanceForCreateItem: ToDoItemImportanceEnum?
        if let importanceString = importance {
            let importanceEnum = ToDoItemImportanceEnum.init(rawValue: importanceString)
            importanceForCreateItem = importanceEnum
        }

        let toDoItem = ToDoItem(
            id: id,
            text: text,
            importance: importanceForCreateItem,
            deadLine: deadLineDate
        )
        return toDoItem
    }
}
