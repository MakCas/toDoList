//
//  FileCache.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

protocol FileCacheProtocol {

    var toDoItems: [ToDoItem] { get }

    func addToDoItem(_ item: ToDoItem)
    func removeItemFor(id: String)
    func saveItemsToFile()
    func loadItemsFromFile() -> [ToDoItem]?
}

// MARK: - Class

final class FileCache {

    private(set) var toDoItems = [ToDoItem]()
    private var fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }
}

// MARK: - FileCacheProtocol

extension FileCache: FileCacheProtocol {

    func addToDoItem(_ item: ToDoItem) {
        toDoItems.append(item)
    }

    func removeItemFor(id: String) {
        toDoItems.removeAll { $0.id == id }
    }

    func saveItemsToFile() {
        do {
            let allItemsJSONData = toDoItems.map({ $0.json })
            let allItemsOneData = try JSONSerialization.data(withJSONObject: allItemsJSONData)
            FileManagerService.shared.saveFileAt(fileName: fileName, fileData: allItemsOneData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func loadItemsFromFile() -> [ToDoItem]? {
        guard let allItemsInOneData = FileManagerService.shared.loadFileDataAt(fileName: fileName) else { return nil }

        do {
            let allItemsJSONS = try JSONSerialization.jsonObject(with: allItemsInOneData) as? [Any]
            return allItemsJSONS?.compactMap { ToDoItem.parse(json: $0) }
        } catch {
            printDebug(error.localizedDescription)
        }
        return nil
    }
}
