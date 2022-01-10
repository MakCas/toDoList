//
//  CreateTaskPresenter.swift
//  toDoList
//
//  Created by User on 04.01.2022.
//

import UIKit

// MARK: - Protocols

protocol CreteTaskViewInput: AnyObject {

    func showDatePicker(for date: Date)
    func hideDatePicker()
    func showDateInLabel(_ date: Date)
    func makeSaveButton(enable: Bool)
    func configureUIWith(toDoItem: ToDoItemViewModel)
}

protocol CreteTaskViewOutput: AnyObject {

    func viewDidLoad()
    func cancelButtonTapped()
    func saveButtonTapped()
    func textViewDidChange(with text: String)
    func importanceChosen(_ importance: ToDoItemImportance)
    func deadLineSwitchChanged(isOn: Bool)
    func datePickerTapped(for date: Date)
}

protocol CreteTaskPresenterUpdateDelegate: AnyObject {

    func updateViewModels()
}

// MARK: - Class

final class CreteTaskPresenter {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & CreteTaskViewInput)?
    weak var updateDelegate: CreteTaskPresenterUpdateDelegate?

    private var router: CreateTaskRouterOutput
    private var toDoItem: ToDoItem
    private var toDoItemViewModel = ToDoItemViewModel()
    
    // MARK: - Init
    
    init(toDoItem: ToDoItem?, router: CreateTaskRouterOutput, updateDelegate: CreteTaskPresenterUpdateDelegate) {
        self.toDoItem = toDoItem ?? ToDoItem(text: "", importance: .usual)
        self.router = router
        self.updateDelegate = updateDelegate
    }
    
    // MARK: - Private Functions
    
    private func makeSaveButtonEnabledIfNeeded() {
        viewInput?.makeSaveButton(enable: !toDoItemViewModel.text.isNilOrEmpty)
    }
}

// MARK: - ChatViewOutput

extension CreteTaskPresenter: CreteTaskViewOutput {
    
    func viewDidLoad() {
        toDoItemViewModel = ToDoItemViewModel(from: toDoItem)
        makeSaveButtonEnabledIfNeeded()
        viewInput?.configureUIWith(toDoItem: toDoItemViewModel)
    }

    func cancelButtonTapped() {
        router.goBack()
    }

    func saveButtonTapped() {
        guard let text = toDoItemViewModel.text else { return }
        toDoItem.text = text
        toDoItem.importance = toDoItemViewModel.importance
        toDoItem.deadLine = toDoItemViewModel.deadLine

        FileCacheService.shared.addOrChangeToDoItem(toDoItem)
        updateDelegate?.updateViewModels()
        router.goBack()
    }

    func textViewDidChange(with text: String) {
        toDoItemViewModel.text = text
        makeSaveButtonEnabledIfNeeded()
    }
    
    func importanceChosen(_ importance: ToDoItemImportance) {
        toDoItemViewModel.importance = importance
        makeSaveButtonEnabledIfNeeded()
    }
    
    func deadLineSwitchChanged(isOn: Bool) {
        if isOn {
            let date = Date()
            toDoItemViewModel.deadLine = date
            viewInput?.showDatePicker(for: date)
        } else {
            toDoItemViewModel.deadLine = nil
            viewInput?.hideDatePicker()
        }
    }
    
    func datePickerTapped(for date: Date) {
        toDoItemViewModel.deadLine = date
        viewInput?.showDateInLabel(date)
    }
}
