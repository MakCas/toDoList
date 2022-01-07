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

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.registerHeaderClass(AllTasksHeaderView.self)
        view.registerCellClass(TaskCell.self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var addTaskControl: AddTaskControl = {
        let control = AddTaskControl()
        control.addTarget(self, action: #selector(addTaskControlTapped), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

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

        presenter.viewDidLoad()
        configureUI()
    }

    // MARK: - UI

    private func configureUI() {
        view.backgroundColor = .backGroundColor
        navigationItem.title = "Мои дела"
        navigationController?.navigationBar.prefersLargeTitles = true

        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(addTaskControl)
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            addTaskControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            addTaskControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskControl.heightAnchor.constraint(equalToConstant: 60),
            addTaskControl.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    // MARK: - Private Functions

    @objc private func addTaskControlTapped() {
        presenter.addTaskControlTapped()
    }
}

// MARK: - UITableViewDelegate

extension AllTasksController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension AllTasksController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.allOrDoneTaskCellViewModels.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = AllTasksHeaderView()
        let doneTasks = presenter.allTaskCellViewModels.map { $0.isDone }.filter { $0 == true }
        view.setNumberDoneTasks(doneTasks.count)
        view.changeHideDoneTasksStatus(for: presenter.showDoneTasksIsSelected)
        view.delegate = self
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell? = tableView.dequeueCell(for: indexPath)
        var typeCell = TypeCell.withoutCorners
        if presenter.allOrDoneTaskCellViewModels.count == 1 {
            typeCell = .willAllCorners
        } else if indexPath.row == 0 {
            typeCell = .first
        } else if indexPath.row == presenter.allOrDoneTaskCellViewModels.count - 1 && presenter.allOrDoneTaskCellViewModels.count != 1 {
            typeCell = .last
        }
        let model = presenter.allOrDoneTaskCellViewModels[indexPath.row]
        cell?.configureCellWith(model: model, typeCell: typeCell)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

// MARK: - AllTasksViewInput

extension AllTasksController: AllTasksViewInput {

    func goToCreateTaskController(for toDoItem: ToDoItem?) {
        router.goToCreateTaskController(for: toDoItem)
    }

    func updateTableView() {
        tableView.reloadData()
    }
}

// MARK: - TaskCellDelegate

extension AllTasksController: TaskCellDelegate {

    func statusChangedFor(taskID: String, to status: Bool) {
        presenter.statusChangedFor(taskID: taskID, to: status)
    }
}

// MARK: - AllTasksHeaderViewDelegate

extension AllTasksController: AllTasksHeaderViewDelegate {

    func showDoneTasksButton(isSelected: Bool) {
        presenter.showDoneTasksButton(isSelected: isSelected)
    }
}
