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
    var allTaskCellViewModels: [TaskCellViewModel] { get }
    var allOrDoneTaskCellViewModels: [TaskCellViewModel] { get }
    var showDoneTasksIsSelected: Bool { get }
    func viewDidLoad()
    func statusChangedFor(taskID: String, to status: Bool)
    func showDoneTasksButton(isSelected: Bool)
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var toDoItems = [ToDoItem]()
    private(set) var allTaskCellViewModels = [TaskCellViewModel]()
    private(set) var allOrDoneTaskCellViewModels = [TaskCellViewModel]()
    private(set) var showDoneTasksIsSelected = true

    private let fileCacheService: FileCacheProtocol = FileCache(fileName: ToDoItemFileNames.allToDoItems)

    // MARK: - Private Functions
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {

    func showDoneTasksButton(isSelected: Bool) {
        showDoneTasksIsSelected = isSelected

        if showDoneTasksIsSelected {
            allOrDoneTaskCellViewModels = allTaskCellViewModels
        } else {
            allOrDoneTaskCellViewModels = allTaskCellViewModels.filter { $0.isDone == false }
        }
        viewInput?.updateTableView()
    }

    func statusChangedFor(taskID: String, to status: Bool) {
        let newTaskModels: [TaskCellViewModel] = allTaskCellViewModels.map { model in
            var model = model
            if model.id == taskID {
                model.isDone = status
            }
            return model
        }
        allTaskCellViewModels = newTaskModels

        if showDoneTasksIsSelected {
            allOrDoneTaskCellViewModels = allTaskCellViewModels
        } else {
            allOrDoneTaskCellViewModels = allTaskCellViewModels.filter { $0.isDone == false }
        }

        viewInput?.updateTableView()
    }

    func viewDidLoad() {
        //        guard let items = fileCacheService.loadItemsFromFile() else {
        //            printDebug("Items were not found for \(ToDoItemFileNames.allToDoItems)")
        //            return
        //        }
        let toDoItems = ToDoItemFactory.buildItems()
        allTaskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
        allOrDoneTaskCellViewModels = allTaskCellViewModels
    }
}
