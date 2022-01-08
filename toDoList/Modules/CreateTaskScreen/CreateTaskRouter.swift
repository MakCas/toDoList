//
//  CreateTaskRouter.swift
//  toDoList
//
//  Created by User on 08.01.2022.
//

import UIKit

protocol CreateTaskRouterOutput: AnyObject {
    
    func goBack()
}

final class CreateTaskRouter {

    weak var viewController: (UIViewController)?
}

extension CreateTaskRouter: CreateTaskRouterOutput {

    func goBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
