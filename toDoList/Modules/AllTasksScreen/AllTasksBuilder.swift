//
//  AllTasksBuilder.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

enum AllTasksBuilder {
    
    static func build() -> (UIViewController & AllTasksViewInput) {
        let presenter = AllTasksPresenter()
        let router = AllTasksRouter()
        let viewController = AllTasksController(presenter: presenter, router: router)
        presenter.viewInput = viewController
        return viewController
    }
}
