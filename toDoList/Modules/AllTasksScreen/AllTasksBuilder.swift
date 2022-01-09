//
//  AllTasksBuilder.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

enum AllTasksBuilder {
    
    static func build() -> (UIViewController & AllTasksViewInput) {
        let router = AllTasksRouter()
        let presenter = AllTasksPresenter(router: router)
        let viewController = AllTasksController(presenter: presenter)
        router.viewController = viewController
        presenter.viewInput = viewController
        return viewController
    }
}
