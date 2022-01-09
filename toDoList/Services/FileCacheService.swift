//
//  FileCache.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

import Foundation

// MARK: - Protocols

protocol FileCacheServiceProtocol {

    var toDoItems: [ToDoItem] { get }

    func removeItemFor(taskId: String)
    func taskDoneStatusChangedFor(taskId: String)
    func addOrChangeToDoItem(_ newOrChangedItem: ToDoItem)
}

// MARK: - Class

final class FileCacheService {

    static let shared: FileCacheServiceProtocol = FileCacheService()

    var toDoItems: [ToDoItem] {
        loadItemsFromFile()
    }
    private var fileName: String = ToDoItemFileNames.allToDoItems

    // MARK: - Init

    private init() {}

    // MARK: - Private Functions

    private func loadItemsFromFile() -> [ToDoItem] {
        guard let allItemsInOneData = FileManagerService.shared.loadFileDataAt(fileName: fileName) else {
            fatalError("LoadItemsFromFile failed")
        }
        do {
            let allItemsJSONS = try JSONSerialization.jsonObject(with: allItemsInOneData) as? [Any]
            if let toDoItems: [ToDoItem] = allItemsJSONS?.compactMap({ ToDoItem.parse(json: $0) }) {
                return toDoItems
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        fatalError("LoadItemsFromFile failed")
    }

    private func saveItemsToFile(_ items: [ToDoItem]) {
        do {
            let allItemsJSONData = items.map({ $0.json })
            let allItemsOneData = try JSONSerialization.data(withJSONObject: allItemsJSONData)
            FileManagerService.shared.saveFileAt(fileName: fileName, fileData: allItemsOneData)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// MARK: - FileCacheProtocol

extension FileCacheService: FileCacheServiceProtocol {

    func removeItemFor(taskId: String) {
        let newToDoItems = toDoItems.filter { $0.id != taskId }
        saveItemsToFile(newToDoItems)
    }

    func taskDoneStatusChangedFor(taskId: String) {
        let newToDoItems: [ToDoItem] = toDoItems.map {
            guard $0.id == taskId else { return $0 }
            var newItem = $0
            newItem.isDone.toggle()
            return newItem
        }
        saveItemsToFile(newToDoItems)
    }

    func addOrChangeToDoItem(_ newOrChangedItem: ToDoItem) {
        var newToDoItems = toDoItems
        if let newOrChangedItemIndex = toDoItems.indices.first(where: { toDoItems[$0].id == newOrChangedItem.id }) {
            newToDoItems[newOrChangedItemIndex] = newOrChangedItem
        } else {
            newToDoItems.append(newOrChangedItem)
        }
        saveItemsToFile(newToDoItems)
    }
}
