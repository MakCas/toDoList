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
    func save(items: [ToDoItem], to fileName: String)
    func loadItemsFromFileWith(name: String) -> [ToDoItem]?
}

// MARK: - Class

final class FileCache {
    
    private(set) var toDoItems = [ToDoItem]()
}

// MARK: - FileCacheProtocol

extension FileCache: FileCacheProtocol {
    
    func addToDoItem(_ item: ToDoItem) {
        toDoItems.append(item)
    }
    
    func removeItemFor(id: String) {
        toDoItems.removeAll { $0.id == id }
    }
    
    func save(items: [ToDoItem], to fileName: String) {
        do {
            let allItemsJSONData = items.map({ $0.json }) as? [Data]
            guard let allItemsJSONData = allItemsJSONData else { return }
            let allItemsOneData = try JSONSerialization.data(withJSONObject: [allItemsJSONData], options: .fragmentsAllowed)
            FileManagerService.shared.saveFileAt(fileName: fileName, fileData: allItemsOneData)
        } catch {
            printDebug(error.localizedDescription)
        }
    }
    
    func loadItemsFromFileWith(name: String) -> [ToDoItem]? {
        guard let allItemsInOneData = FileManagerService.shared.loadFileDataAt(fileName: name) else { return nil }
        
        do {
            let allItemsJSONS = try JSONSerialization.jsonObject(with: allItemsInOneData, options: .fragmentsAllowed) as? [Data]
            guard let toDoItemsOneData = allItemsJSONS else { return nil }
            let toDoItems: [ToDoItem] = toDoItemsOneData.compactMap { jsonData in
                let toDoItem = ToDoItem.parse(json: jsonData)
                return toDoItem
            }
            return toDoItems.isEmpty ? nil: toDoItems
        } catch {
            printDebug(error.localizedDescription)
            return nil
        }
    }
}
