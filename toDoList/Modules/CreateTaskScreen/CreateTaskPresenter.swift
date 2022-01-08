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
    func goBack()
}

protocol CreteTaskViewOutput: AnyObject {
    func viewDidLoad()
    func textViewDidChange(with text: String)
    func importanceChosen(_ importance: ToDoItemImportance)
    func deadLineSwitchChanged(isOn: Bool)
    func datePickerTapped(for date: Date)
    func saveButtonTapped()
    func cancelButtonTapped()
}

// MARK: - Class

final class CreteTaskPresenter {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & CreteTaskViewInput)?
    private var toDoItem: ToDoItem?
    private var toDoItemViewModel = ToDoItemViewModel()
    
    // MARK: - Init
    
    init(toDoItem: ToDoItem?) {
        self.toDoItem = toDoItem
    }
    
    // MARK: - Private Functions
    
    private func makeSaveButtonEnabledIfNeeded() {
        viewInput?.makeSaveButton(enable: !toDoItemViewModel.text.isNilOrEmpty)
    }
}

// MARK: - ChatViewOutput

extension CreteTaskPresenter: CreteTaskViewOutput {
    
    func cancelButtonTapped() {
        viewInput?.goBack()
    }
    
    
    func viewDidLoad() {
        if let toDoItem = toDoItem {
            toDoItemViewModel = ToDoItemViewModel(from: toDoItem)
        } else {
            toDoItemViewModel = ToDoItemViewModel()
        }
        viewInput?.configureUIWith(toDoItem: toDoItemViewModel)
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
    
    func saveButtonTapped() {
        guard let text = toDoItemViewModel.text else { return }
        let toDoItem = ToDoItem(text: text, importance: toDoItemViewModel.importance, deadLine: toDoItemViewModel.deadLine)
        printDebug(toDoItem)
        return
    }
}
