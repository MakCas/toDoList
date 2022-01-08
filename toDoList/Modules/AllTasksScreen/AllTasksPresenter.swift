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
    func goToCreateTaskController(for toDoItem: ToDoItem?)
}

protocol AllTasksViewOutput: AnyObject {
    var allTaskCellViewModels: [TaskCellViewModel] { get }
    var allOrDueTaskCellViewModels: [TaskCellViewModel] { get }
    var showDoneTasksIsSelected: Bool { get }

    func viewDidLoad()
    func doneStatusChangedFor(taskID: String?, indexPathRow: Int?)
    func showDoneTasksButton(isSelected: Bool)
    func addTaskControlTapped()
    func taskCellTapped(for indexPathRow: Int)
    func deleteTask(for indexPath: IndexPath)
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var toDoItems = [ToDoItem]() {
        didSet {
            allTaskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
            configureAllOrDoneTaskCellViewModels()
        }
    }
    private(set) var allTaskCellViewModels = [TaskCellViewModel]()
    private(set) var allOrDueTaskCellViewModels = [TaskCellViewModel]()
    private(set) var showDoneTasksIsSelected = false

    // MARK: - Private Functions

    private func configureAllOrDoneTaskCellViewModels() {
        if showDoneTasksIsSelected {
            allOrDueTaskCellViewModels = allTaskCellViewModels
        } else {
            allOrDueTaskCellViewModels = allTaskCellViewModels.filter { $0.isDone == false }
        }
    }
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {

    func deleteTask(for indexPath: IndexPath) {
        let deletedTaskModel = allOrDueTaskCellViewModels[indexPath.row]

        toDoItems.removeAll { item in
            if item.id == deletedTaskModel.id {
                return true
            } else {
                return false
            }
        }
        viewInput?.updateTableView()
    }

    func taskCellTapped(for indexPathRow: Int) {
        let tappedModel = allOrDueTaskCellViewModels[indexPathRow]

        let toDoItem = ToDoItem(
            id: tappedModel.id,
            text: tappedModel.itemText.string,
            importance: tappedModel.itemImportance,
            deadLine: tappedModel.deadLine,
            isDone: tappedModel.isDone
        )

        viewInput?.goToCreateTaskController(for: toDoItem)
    }

    func addTaskControlTapped() {
        viewInput?.goToCreateTaskController(for: nil)
    }

    func showDoneTasksButton(isSelected: Bool) {
        showDoneTasksIsSelected = isSelected

        configureAllOrDoneTaskCellViewModels()
        viewInput?.updateTableView()
    }

    func doneStatusChangedFor(taskID: String?, indexPathRow: Int?) {
        var changedTaskModelId: String?

        if let taskID = taskID {
            changedTaskModelId = taskID
        } else if let indexPathRow = indexPathRow {
            changedTaskModelId = allOrDueTaskCellViewModels[indexPathRow].id
        }
        guard let changedTaskModelId = changedTaskModelId else { return }

        toDoItems = toDoItems.map { item in
            if item.id == changedTaskModelId {
                return ToDoItem(
                    id: item.id,
                    text: item.text,
                    importance: item.importance,
                    deadLine: item.deadLine,
                    isDone: !item.isDone
                )
            }
            return item
        }
        viewInput?.updateTableView()
    }

    func viewDidLoad() {
        toDoItems = ToDoItemFactory.buildItems()
    }
}
