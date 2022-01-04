//
//  CreateTaskBuilder.swift
//  toDoList
//
//  Created by User on 04.01.2022.
//

import UIKit

enum CreateTaskBuilder {
    
    static func build() -> (UIViewController & CreteTaskViewInput) {
        
        let presenter = CreteTaskPresenter()
        let viewController = CreateTaskController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
