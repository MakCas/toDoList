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
}

// MARK: - Class

final class FileCache {

    static let shared: FileCacheProtocol = FileCache()

    private(set) var toDoItems = [ToDoItem]()
    private var fileName: String = ToDoItemFileNames.allToDoItems

    private init() {
        loadItemsFromFile()
    }
}

// MARK: - FileCacheProtocol

extension FileCache: FileCacheProtocol {

    func addToDoItem(_ item: ToDoItem) {
        toDoItems.append(item)
        saveItemsToFile()
    }

    func removeItemFor(id: String) {
        toDoItems.removeAll { $0.id == id }
        saveItemsToFile()
    }

    func changeToDoItemFor(id: String, with newItem: ToDoItem) {
        toDoItems = toDoItems.map { item in
            if item.id == id {
                return newItem
            } else {
                return item
            }
        }
        saveItemsToFile()
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

    func loadItemsFromFile() {
        guard let allItemsInOneData = FileManagerService.shared.loadFileDataAt(fileName: fileName) else { return }

        do {
            let allItemsJSONS = try JSONSerialization.jsonObject(with: allItemsInOneData) as? [Any]
            if let toDoItems: [ToDoItem] = allItemsJSONS?.compactMap({ ToDoItem.parse(json: $0) }) {
                self.toDoItems = toDoItems
            }
        } catch {
            printDebug(error.localizedDescription)
        }
        return
    }
}
