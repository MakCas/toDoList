//
//  CreateTaskBuilder.swift
//  toDoList
//
//  Created by User on 04.01.2022.
//

import UIKit

enum CreateTaskBuilder {
    
    static func build(with toDoItem: ToDoItem?) -> (UIViewController & CreteTaskViewInput) {
        
        let presenter = CreteTaskPresenter(toDoItem: toDoItem)
        let router = CreateTaskRouter()
        let viewController = CreateTaskController(presenter: presenter, router: router)
        presenter.viewInput = viewController
        router.viewController = viewController
        return viewController
    }
}
