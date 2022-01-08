//
//  CreateTaskController.swift
//  toDoList
//
//  Created by User on 31.12.2021.
//

import UIKit

final class CreateTaskController: UIViewController {
    
    // MARK: - Layout
    
    enum Layout {
        
        static let fontSize: CGFloat = 18
        
        enum TopStackView {
            static let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            static let height: CGFloat = 50
            static let minimumLineSpacing: CGFloat = 10
            
            static let cancelButtonTextKey = "cancelButtonText".localised()
            static let nameScreenLabelTextKey = "nameScreenLabelText".localised()
            static let saveButtonTextKey = "saveButtonText".localised()
        }
        
        enum ScrollView {
            static let insets = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: -16)
        }
        
        enum BigStackView {
            static let minimumLineSpacing: CGFloat = 15
        }
        
        enum ImportanceView {
            static let height: CGFloat = 65
        }
        
        enum DeadLineView {
            static let height: CGFloat = 65
        }
        
        enum TextView {
            static let height: CGFloat = 150
        }
        
        enum DeleteButton {
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 60
            static let title = "delete".localised()
        }
        
        enum ContainerForSmallStackView {
            static let cornerRadius: CGFloat = 16
        }
    }
    
    // MARK: - Subviews
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.TopStackView.cancelButtonTextKey, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameScreenLabel: UILabel = {
        let label = UILabel()
        label.text = Layout.TopStackView.nameScreenLabelTextKey
        label.font = UIFont.systemFont(ofSize: Layout.fontSize, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.TopStackView.saveButtonTextKey, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Layout.fontSize, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray2, for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bigStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Layout.BigStackView.minimumLineSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var taskTextView: TextViewWithPlaceholder = {
        let textView = TextViewWithPlaceholder()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.customDelegate = self
        return textView
    }()
    
    private lazy var containerForSmallStackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.ContainerForSmallStackView.cornerRadius
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var smallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var importanceView: ImportanceView = {
        let view = ImportanceView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deadLineView: DeadLineView = {
        let view = DeadLineView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var calendarDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(datePickerTapped(sender:)), for: .valueChanged)
        datePicker.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Layout.DeleteButton.title, for: .normal)
        button.layer.cornerRadius = Layout.DeleteButton.cornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.setTitleColor(.systemGray2, for: .disabled)
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private var presenter: CreteTaskViewOutput
    private var keyboardHeight: CGFloat?
    
    // MARK: - Init
    
    init(presenter: CreteTaskViewOutput) {
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
        //        addScrollViewGesture()
        configureUI()
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: - UI
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //    private func addScrollViewGesture() {
    //        scrollView.isUserInteractionEnabled = true
    //        let gesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
    //        scrollView.addGestureRecognizer(gesture)
    //    }
    
    //    @objc private func scrollViewTapped() {
    //        view.endEditing(true)
    //    }
    
    @objc private func datePickerTapped(sender: UIDatePicker) {
        presenter.datePickerTapped(for: sender.date)
    }
    
    private func configureUI() {
        view.backgroundColor = .backGroundColor
        
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(topStackView)
        topStackView.addArrangedSubview(cancelButton)
        topStackView.addArrangedSubview(nameScreenLabel)
        topStackView.addArrangedSubview(saveButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(bigStackView)
        
        bigStackView.addArrangedSubview(taskTextView)
        bigStackView.addArrangedSubview(containerForSmallStackView)
        
        containerForSmallStackView.addSubview(smallStackView)
        smallStackView.addArrangedSubview(importanceView)
        smallStackView.addArrangedSubview(deadLineView)
        smallStackView.addArrangedSubview(calendarDatePicker)
        
        bigStackView.addArrangedSubview(deleteButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.TopStackView.insets.left),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.TopStackView.insets.right),
            topStackView.heightAnchor.constraint(equalToConstant: Layout.TopStackView.height),
            
            scrollView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: Layout.ScrollView.insets.top),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.ScrollView.insets.left),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.ScrollView.insets.right),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            bigStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bigStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bigStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bigStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bigStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            taskTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: Layout.TextView.height),
            importanceView.heightAnchor.constraint(equalToConstant: Layout.ImportanceView.height),
            deadLineView.heightAnchor.constraint(equalToConstant: Layout.DeadLineView.height),
            
            smallStackView.topAnchor.constraint(equalTo: containerForSmallStackView.topAnchor),
            smallStackView.leadingAnchor.constraint(equalTo: containerForSmallStackView.leadingAnchor),
            smallStackView.trailingAnchor.constraint(equalTo: containerForSmallStackView.trailingAnchor),
            smallStackView.bottomAnchor.constraint(equalTo: containerForSmallStackView.bottomAnchor),
            
            deleteButton.heightAnchor.constraint(equalToConstant: Layout.DeleteButton.height)
        ])
    }
    
    // MARK: - Private Functions
    
    @objc private func saveButtonTapped() {
        presenter.saveButtonTapped()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardSize.cgRectValue.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

// MARK: - DeadLineViewDelegate

extension CreateTaskController: DeadLineViewDelegate {
    
    func deadLineSwitchChanged(isOn: Bool) {
        presenter.deadLineSwitchChanged(isOn: isOn)
    }
}

// MARK: - CreteTaskViewInput

extension CreateTaskController: CreteTaskViewInput {
    
    func configureUIWith(toDoItem: ToDoItemViewModel) {
        importanceView.setSegmentControl(for: toDoItem.importance)
        
        if let text = toDoItem.text {
            taskTextView.change(text: text)
        }
        
        guard let date = toDoItem.deadLine else { return }
        calendarDatePicker.isHidden = false
        deadLineView.makeSwitcherOn()
        deadLineView.makeLayoutForSwitcherIsON(for: date)
        calendarDatePicker.setDate(date, animated: false)
    }
    
    func makeSaveButton(enable: Bool) {
        saveButton.isEnabled = enable
    }
    
    func showDateInLabel(_ date: Date) {
        deadLineView.dateChosen(date)
    }
    
    func showDatePicker(for date: Date) {
        calendarDatePicker.isHidden = false
        calendarDatePicker.setDate(date, animated: false)
        deadLineView.makeLayoutForSwitcherIsON(for: date)
    }
    
    func hideDatePicker() {
        calendarDatePicker.isHidden = true
        deadLineView.makeLayoutForSwitcherIsOff()
    }
}

// MARK: - TextViewWithPlaceholderDelegate

extension CreateTaskController: TextViewWithPlaceholderDelegate {
    
    func textViewDidChange(with text: String) {
        presenter.textViewDidChange(with: text)
    }
}

// MARK: - ImportanceViewDelegate

extension CreateTaskController: ImportanceViewDelegate {
    
    func importanceChosen(_ importance: ToDoItemImportance) {
        presenter.importanceChosen(importance)
    }
}
