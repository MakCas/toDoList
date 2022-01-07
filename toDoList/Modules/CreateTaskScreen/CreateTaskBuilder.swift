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
        let viewController = CreateTaskController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
