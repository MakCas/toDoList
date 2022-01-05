//
//  AllTasksRouter.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

protocol AllTasksRouterOutput: AnyObject {}

final class AllTasksRouter {

    weak var viewController: (UIViewController)?
}

extension AllTasksRouter: AllTasksRouterOutput {}
