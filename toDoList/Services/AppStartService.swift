//
//  AppStartService.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

// MARK: - Protocols

protocol AppStartProtocol {
    
    func start()
}

// MARK: - Class

final class AppStartService {
    
    // MARK: - Properties
    
    var window: UIWindow?
    private lazy var navVC: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
}

// MARK: - AppStartProtocol

extension AppStartService: AppStartProtocol {
    
    func start() {
        let rootVC = AllTasksBuilder.build()
        navVC.viewControllers = [rootVC]
        
        window!.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
