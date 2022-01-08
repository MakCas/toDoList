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
    func showDoneTasksButton(isSelected: Bool)
    func taskDoneStatusChangedFor(taskID: String?, indexPathRow: Int?)
    func deleteTask(for indexPath: IndexPath)
    func taskCellTapped(for indexPathRow: Int)
    func addTaskControlTapped()
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var toDoItems = [ToDoItem]() {
        didSet {
            allTaskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
            configureAllOrDueTaskCellViewModels()
        }
    }
    private(set) var allTaskCellViewModels = [TaskCellViewModel]()
    private(set) var allOrDueTaskCellViewModels = [TaskCellViewModel]()
    private(set) var showDoneTasksIsSelected = false

    // MARK: - Private Functions

    private func configureAllOrDueTaskCellViewModels() {
        if showDoneTasksIsSelected {
            allOrDueTaskCellViewModels = allTaskCellViewModels
        } else {
            allOrDueTaskCellViewModels = allTaskCellViewModels.filter { $0.isDone == false }
        }
    }
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {

    func viewDidLoad() {
        toDoItems = ToDoItemFactory.buildItems()
    }

    func showDoneTasksButton(isSelected: Bool) {
        showDoneTasksIsSelected = isSelected
        configureAllOrDueTaskCellViewModels()
        viewInput?.updateTableView()
    }

    func taskDoneStatusChangedFor(taskID: String?, indexPathRow: Int?) {
        var changedTaskModelId: String?
        if let taskID = taskID {
            changedTaskModelId = taskID
        } else if let indexPathRow = indexPathRow {
            changedTaskModelId = allOrDueTaskCellViewModels[indexPathRow].id
        }
        guard let changedTaskModelId = changedTaskModelId else { return }

        toDoItems = toDoItems.map { item in
            guard item.id == changedTaskModelId else { return item }
            return ToDoItem(
                id: item.id,
                text: item.text,
                importance: item.importance,
                deadLine: item.deadLine,
                isDone: !item.isDone
            )
        }
        viewInput?.updateTableView()
    }

    func deleteTask(for indexPath: IndexPath) {
        let deletedTaskModel = allOrDueTaskCellViewModels[indexPath.row]
        toDoItems.removeAll { item in
            guard item.id == deletedTaskModel.id else { return false }
            return true
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
}
