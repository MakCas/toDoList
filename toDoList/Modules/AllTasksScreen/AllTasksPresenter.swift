//
//  AllTasksPresenter.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

// MARK: - Protocols

protocol AllTasksViewInput: AnyObject {
    func updateTableView()
}

protocol AllTasksViewOutput: AnyObject {
    var taskCellViewModels: [TaskCellViewModel] { get }
    func viewDidLoad()
    func statusChangedFor(taskID: String, to status: Bool)
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var toDoItems = [ToDoItem]()
    private(set) var taskCellViewModels = [TaskCellViewModel]()
    private let fileCacheService: FileCacheProtocol = FileCache(fileName: ToDoItemFileNames.allToDoItems)

    // MARK: - Private Functions
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {

    func statusChangedFor(taskID: String, to status: Bool) {
        let newTaskModels: [TaskCellViewModel] = taskCellViewModels.map { model in
            var model = model
            if model.id == taskID {
                model.isDone = status
            }
            return model
        }
        taskCellViewModels = newTaskModels
        viewInput?.updateTableView()
    }

    func viewDidLoad() {
        //        guard let items = fileCacheService.loadItemsFromFile() else {
        //            printDebug("Items were not found for \(ToDoItemFileNames.allToDoItems)")
        //            return
        //        }
        let toDoItems = ToDoItemFactory.buildItems()
        taskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
    }
}
