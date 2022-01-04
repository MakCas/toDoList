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
}

protocol CreteTaskViewOutput: AnyObject {
    func deadLineSwitchChanged(isOn: Bool)
    func datePickerTapped(sender: UIDatePicker)
}

// MARK: - Class

final class CreteTaskPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & CreteTaskViewInput)?
    private var toDoItem: ToDoItem?
    private var toDoItemViewModel = ToDoItemViewModel()
    
    // MARK: - Functions

}

// MARK: - ChatViewOutput

extension CreteTaskPresenter: CreteTaskViewOutput {

    func deadLineSwitchChanged(isOn: Bool) {
        isOn ? viewInput?.showDatePicker(for: Date()) : viewInput?.hideDatePicker()
    }

    func datePickerTapped(sender: UIDatePicker) {

    }
}
