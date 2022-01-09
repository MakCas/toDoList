//
//  CreateTaskBuilder.swift
//  toDoList
//
//  Created by User on 04.01.2022.
//

import UIKit

enum CreateTaskBuilder {
    
    static func build(with toDoItem: ToDoItem?, presenterDelegate: CreteTaskPresenterUpdateDelegate) -> (UIViewController & CreteTaskViewInput) {
        
        let router = CreateTaskRouter()
        let presenter = CreteTaskPresenter(toDoItem: toDoItem, router: router, updateDelegate: presenterDelegate)
        let viewController = CreateTaskController(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        return viewController
    }
}
