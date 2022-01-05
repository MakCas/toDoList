//
//  AllTasksController.swift
//  toDoList
//
//  Created by User on 05.01.2022.
//

import UIKit

final class AllTasksController: UIViewController {

    // MARK: - Layout

    enum Layout {

    }

    // MARK: - Subviews

    // MARK: - Properties

    private var presenter: AllTasksViewOutput
    private var router: AllTasksRouterOutput

    // MARK: - Init

    init(presenter: AllTasksViewOutput, router: AllTasksRouterOutput) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - UI


    private func configureUI() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Private Functions
}

extension AllTasksController: AllTasksViewInput {

}
