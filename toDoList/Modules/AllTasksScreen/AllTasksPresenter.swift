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
    func deleteRows(at indexPath: [IndexPath])
}

protocol AllTasksViewOutput: AnyObject {
    var allTaskCellViewModels: [TaskCellViewModel] { get }
    var allOrDoneTaskCellViewModels: [TaskCellViewModel] { get }
    var showDoneTasksIsSelected: Bool { get }
    func viewDidLoad()
    func statusChangedFor(taskID: String?, indexPathRow: Int?)
    func showDoneTasksButton(isSelected: Bool)
    func addTaskControlTapped()
    func taskCellTapped(for indexPathRow: Int)
    func deleteTask(for indexPath: IndexPath)
}

// MARK: - Class

final class AllTasksPresenter {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & AllTasksViewInput)?
    private var toDoItems = [ToDoItem]()
    private(set) var allTaskCellViewModels = [TaskCellViewModel]()
    private(set) var allOrDoneTaskCellViewModels = [TaskCellViewModel]()
    private(set) var showDoneTasksIsSelected = true
    
    // MARK: - Private Functions
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {
    
    func deleteTask(for indexPath: IndexPath) {
        printDebug("deleteTask worked")
        allOrDoneTaskCellViewModels.remove(at: indexPath.row)
        viewInput?.updateTableView()
        //        viewInput?.deleteRows(at: [indexPath])
    }
    
    func taskCellTapped(for indexPathRow: Int) {
        let tappedModel = allTaskCellViewModels[indexPathRow]
        
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
        
        if showDoneTasksIsSelected {
            allOrDoneTaskCellViewModels = allTaskCellViewModels
        } else {
            allOrDoneTaskCellViewModels = allTaskCellViewModels.filter { $0.isDone == false }
        }
        viewInput?.updateTableView()
    }
    
    func statusChangedFor(taskID: String?, indexPathRow: Int?) {
        
        var newTaskModels = allTaskCellViewModels
        
        if let taskID = taskID {
            newTaskModels = allTaskCellViewModels.map { model in
                var model = model
                if model.id == taskID {
                    model.isDone.toggle()
                }
                return model
            }
        } else if let indexPathRow = indexPathRow {
            var model = allTaskCellViewModels[indexPathRow]
            model.isDone.toggle()
            newTaskModels[indexPathRow] = model
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
        toDoItems = FileCache.shared.toDoItems
        toDoItems = ToDoItemFactory.buildItems()
        allTaskCellViewModels = toDoItems.map { TaskCellViewModel.init(from: $0) }
        allOrDoneTaskCellViewModels = allTaskCellViewModels
    }
}
