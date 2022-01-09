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
        
        enum NavigationItem {
            static let title = "titleForAllTaskController".localised()
        }
        
        enum TableView {
            static let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
        }
        
        enum HeaderView {
            static let height: CGFloat = 40
        }
        
        enum AddTaskControl {
            static let bottomInset: CGFloat = -15
            static let size: CGFloat = 60
        }
    }
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.registerHeaderClass(AllTasksHeaderView.self)
        tableView.registerCellClass(TaskCell.self)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addTaskControl: AddTaskControl = {
        let control = AddTaskControl()
        control.addTarget(self, action: #selector(addTaskControlTapped), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    // MARK: - Properties
    
    private var presenter: AllTasksViewOutput
    
    private var cellViewModels = [TaskCellViewModel]()
    private var doneTasksCount = 0
    private var showDoneTasksIsSelected = false
    
    // MARK: - Init
    
    init(presenter: AllTasksViewOutput) {
        self.presenter = presenter
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
        navigationItem.title = Layout.NavigationItem.title
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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.TableView.insets.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.TableView.insets.right),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addTaskControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Layout.AddTaskControl.bottomInset),
            addTaskControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTaskControl.heightAnchor.constraint(equalToConstant: Layout.AddTaskControl.size),
            addTaskControl.widthAnchor.constraint(equalToConstant: Layout.AddTaskControl.size)
        ])
    }
    
    // MARK: - Private Functions
    
    @objc private func addTaskControlTapped() {
        presenter.addTaskControlTapped()
    }
    
    private func setTypeCell(with indexPathRow: Int, for numberOfCells: Int) -> TypeCell {
        if numberOfCells == 1 {
            return .willAllMaskedCorners
        } else if indexPathRow == 0 {
            return .withTopMaskedCorners
        } else if indexPathRow == numberOfCells - 1 && numberOfCells != 1 {
            return .withBottomMaskedCorners
        }
        return .withoutMaskedCorners
    }
}

// MARK: - UITableViewDelegate

extension AllTasksController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedTaskModelId = cellViewModels[indexPath.row].id
        presenter.taskCellTappedFor(taskID: tappedTaskModelId)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeCheckDone = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            guard let changedTaskModelId = self?.cellViewModels[indexPath.row].id else { return }
            self?.presenter.taskDoneStatusChangedFor(taskId: changedTaskModelId)
        }
        swipeCheckDone.image = .checkMarkCircleFill
        swipeCheckDone.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [swipeCheckDone])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeInfo = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            guard let tappedTaskModelId = self?.cellViewModels[indexPath.row].id else { return }
            self?.presenter.taskCellTappedFor(taskID: tappedTaskModelId)
        }
        swipeInfo.image = .infoCircleFill
        
        let swipeDelete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            guard let deletedTaskModelId = self?.cellViewModels[indexPath.row].id else { return }
            self?.presenter.deleteTaskFor(taskID: deletedTaskModelId)
        }
        swipeDelete.image = .trashFill
        
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeInfo])
    }
}

// MARK: - UITableViewDataSource

extension AllTasksController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = AllTasksHeaderView()
        view.layer.masksToBounds = true
        view.setNumberDoneTasks(doneTasksCount)
        view.changeHideDoneTasksStatus(for: showDoneTasksIsSelected)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.HeaderView.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell? = tableView.dequeueCell(for: indexPath)
        
        let numberOfCells = cellViewModels.count
        let typeCell = setTypeCell(with: indexPath.row, for: numberOfCells)
        let taskViewModel = cellViewModels[indexPath.row]
        
        cell?.configureCellWith(model: taskViewModel, typeCell: typeCell)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

// MARK: - AllTasksViewInput

extension AllTasksController: AllTasksViewInput {
    
    func update(cellViewModels: [TaskCellViewModel], doneTasksCount: Int, showDoneTasksIsSelected: Bool) {
        self.cellViewModels = cellViewModels
        self.doneTasksCount = doneTasksCount
        self.showDoneTasksIsSelected = showDoneTasksIsSelected
        tableView.reloadData()
    }
}

// MARK: - TaskCellDelegate

extension AllTasksController: TaskCellDelegate {
    
    func statusChangedFor(taskID: String) {
        presenter.taskDoneStatusChangedFor(taskId: taskID)
    }
}

// MARK: - AllTasksHeaderViewDelegate

extension AllTasksController: AllTasksHeaderViewDelegate {
    
    func showDoneTasksButton(isSelected: Bool) {
        presenter.showDoneTasksButton(isSelected: isSelected)
    }
}
