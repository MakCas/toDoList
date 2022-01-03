//
//  ToDoItem.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import UIKit

struct ToDoItem {

    // MARK: - Structure

    enum Importance: String {

        case notImportant
        case usual
        case important
    }

    // MARK: - Properties

    let id: String
    let text: String
    let importance: Importance
    let deadLine: Date?

    // MARK: - Init

    init(
        id: String = UUID().uuidString,
        text: String,
        importance: Importance,
        deadLine: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadLine = deadLine
    }
}

// MARK: - Extension

extension ToDoItem {
    
    var json: Any {
        var toDoItemDictionary: [String: Any] = [
            "id": id as Any,
            "text": text as Any
        ]
        
        if importance != .usual {
            toDoItemDictionary["importance"] = importance.rawValue as Any
        }

        if let deadLine = deadLine?.timeIntervalSince1970 {
            toDoItemDictionary["deadLine"] = deadLine as Any
        }
        
        do {
            return try JSONSerialization.data(withJSONObject: toDoItemDictionary)
        } catch {
            fatalError("Error during serialization")
        }
    }

    static func parse(json: Any) -> ToDoItem? {
        guard
            let toDoItemJson = json as? [String: Any],
            let id = toDoItemJson["id"] as? String,
            let text = toDoItemJson["text"] as? String
        else {
            return nil
        }

        let importance = toDoItemJson["importance"] as? String
        let deadLine = toDoItemJson["deadLine"] as? TimeInterval

        var deadLineDate: Date?
        if let deadLine = deadLine {
            deadLineDate = Date(timeIntervalSince1970: deadLine)
        }

        var importanceForCreateItem: Importance?
        if let importanceString = importance {
            importanceForCreateItem = .init(rawValue: importanceString)
        }

        return ToDoItem(
            id: id,
            text: text,
            importance: importanceForCreateItem ?? .usual,
            deadLine: deadLineDate
        )
    }
}
