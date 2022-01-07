//
//  AllTasksPresenter.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

// MARK: - Protocols

protocol AllTasksViewInput: AnyObject {
}

protocol AllTasksViewOutput: AnyObject {
    var taskCellViewModels: [TaskCellViewModel] { get }
    func viewDidLoad()
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private(set) var taskCellViewModels = [TaskCellViewModel]()
    private var toDoItems = [ToDoItem]()
    private let fileCacheService: FileCacheProtocol = FileCache(fileName: ToDoItemFileNames.allToDoItems)

    // MARK: - Private Functions
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {
    func viewDidLoad() {
        //        guard let items = fileCacheService.loadItemsFromFile() else {
        //            printDebug("Items were not found for \(ToDoItemFileNames.allToDoItems)")
        //            return
        //        }
        let toDoItems = ToDoItemFactory.buildItems()
        taskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
    }
}
