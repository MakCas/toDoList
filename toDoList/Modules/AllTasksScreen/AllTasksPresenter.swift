//
//  AllTasksPresenter.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

// MARK: - Protocols

protocol AllTasksViewInput: AnyObject {
    
    func update(cellViewModels: [TaskCellViewModel], doneTasksCount: Int, showDoneTasksIsSelected: Bool)
}

protocol AllTasksViewOutput: AnyObject {
    
    func viewDidLoad()
    func showDoneTasksButton(isSelected: Bool)
    func taskDoneStatusChangedFor(taskId: String)
    func deleteTaskFor(taskID: String)
    func taskCellTappedFor(taskID: String)
    func addTaskControlTapped()
}

// MARK: - Class

final class AllTasksPresenter {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var router: AllTasksRouterOutput
    private var toDoItems: [ToDoItem] {
        return FileCacheService.shared.toDoItems
    }
    private var showDoneTasksIsSelected = true

    // MARK: - Init
    
    init(router: AllTasksRouterOutput) {
        self.router = router
    }
}

// MARK: - AllTasksViewOutput

extension AllTasksPresenter: AllTasksViewOutput {
    
    func viewDidLoad() {
        updateViewModels()
    }

    func showDoneTasksButton(isSelected: Bool) {
        showDoneTasksIsSelected = isSelected
        updateViewModels()
    }
    
    func taskDoneStatusChangedFor(taskId: String) {
        FileCacheService.shared.taskDoneStatusChangedFor(taskId: taskId)
        updateViewModels()
    }
    
    func deleteTaskFor(taskID: String) {
        FileCacheService.shared.removeItemFor(taskId: taskID)
        updateViewModels()
    }
    
    func taskCellTappedFor(taskID: String) {
        guard let toDoItem = toDoItems.first(where: { $0.id == taskID }) else { return }
        router.goToCreateTaskController(for: toDoItem, with: self)
    }
    
    func addTaskControlTapped() {
        router.goToCreateTaskController(for: nil, with: self)
    }
}

// MARK: - CreteTaskPresenterUpdateDelegate

extension AllTasksPresenter: CreteTaskPresenterUpdateDelegate {
    
    func updateViewModels() {
        let allOrDueTaskCellViewModels = toDoItems
            .map { TaskCellViewModel.init(from: $0) }
            .filter { showDoneTasksIsSelected || !$0.isDone }
        let doneTasksCount = toDoItems.filter { $0.isDone }.count
        viewInput?.update(cellViewModels: allOrDueTaskCellViewModels, doneTasksCount: doneTasksCount, showDoneTasksIsSelected: showDoneTasksIsSelected)
    }
}
