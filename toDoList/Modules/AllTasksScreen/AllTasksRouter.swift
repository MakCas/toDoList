//
//  AllTasksRouter.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

protocol AllTasksRouterOutput: AnyObject {

    func goToCreateTaskController(for toDoItem: ToDoItem?)
}

final class AllTasksRouter {

    weak var viewController: (UIViewController)?
}

extension AllTasksRouter: AllTasksRouterOutput {

    func goToCreateTaskController(for toDoItem: ToDoItem?) {
        let controller = CreateTaskBuilder.build(with: toDoItem)
        viewController?.present(controller, animated: true, completion: nil)
    }
}
