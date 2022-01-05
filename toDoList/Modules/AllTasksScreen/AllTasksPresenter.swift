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
}

// MARK: - Class

final class AllTasksPresenter {

    // MARK: - Properties

    weak var viewInput: (UIViewController & AllTasksViewInput)?

    // MARK: - Private Functions
}

// MARK: - ChatViewOutput

extension AllTasksPresenter: AllTasksViewOutput {

}
