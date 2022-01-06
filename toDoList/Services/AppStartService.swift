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
        configureNavBarAppearance()
        configureTableViewAppearance()
    }

    // MARK: - Private Functions

    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        if #available(iOS 15, *) {
            appearance.configureWithOpaqueBackground()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear

        }
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func configureTableViewAppearance() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
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
