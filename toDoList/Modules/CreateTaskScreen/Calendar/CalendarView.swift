//
//  CalendarView.swift
//  toDoList
//
//  Created by User on 02.01.2022.
//

import UIKit

final class CalendarView: UIView {
    
    // MARK: - Properties
    
    private let selectedDate: Date
    
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            collectionView.reloadData()
        }
    }
    
    private lazy var days = generateDaysInMonth(for: baseDate)
    
    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)
    
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    // MARK: - Subviews
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }

        //      self.dismiss(animated: true)
        printDebug("CalendarPickerHeaderView tapped")
    }

    // MARK: - Init
    
    init(baseDate: Date, selectedDateChanged: @escaping ((Date) -> Void)) {
        self.selectedDate = baseDate
        self.selectedDateChanged = selectedDateChanged
        self.baseDate = baseDate
        super.init(frame: .zero)

        backgroundColor = .white
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        addSubview(headerView)

        
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        var constraints = [NSLayoutConstraint]()

        constraints.append(contentsOf: [
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85)
        ])

        constraints.append(contentsOf: [
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate(constraints)
        headerView.baseDate = baseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Day Generation

private extension CalendarView {

    func monthMetadata(for baseDate: Date) -> MonthMetadata? {
        guard
            let numberOfDaysInMonth = calendar.range(
                of: .day,
                in: .month,
                for: baseDate)?.count,
            let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            printDebug("monthMetadata failed")
            return nil
        }

        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)

        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }

    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = monthMetadata(for: baseDate) else {
            printDebug("generateDaysInMonth failed")
            return []
        }

        let numberOfDaysInMonth = metadata.numberOfDays

        var offsetInInitialRow = 0

        if metadata.firstDayWeekday == 1 {
            offsetInInitialRow = metadata.firstDayWeekday + 6
        } else {
            offsetInInitialRow = metadata.firstDayWeekday - 1
        }

        let firstDayOfMonth = metadata.firstDay

        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in

                let isWithinDisplayedMonth = day >= offsetInInitialRow
                let dayOffset =
                isWithinDisplayedMonth ?
                day - offsetInInitialRow :
                -(offsetInInitialRow - day)

                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }

        days += generateStartOfNextMonth(using: firstDayOfMonth)

        return days
    }

    // 7
    func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
        ?? baseDate

        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
            isWithinDisplayedMonth: isWithinDisplayedMonth
        )
    }

    // 1
    func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
    ) -> [Day] {
        // 2
        guard
            let lastDayInMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfDisplayedMonth)
        else {
            return []
        }

        // 3
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }

        // 4
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }

        return days
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        days.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let day = days[indexPath.row]

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
            for: indexPath) as? CalendarDateCollectionViewCell

        cell?.day = day
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let day = days[indexPath.row]
        selectedDateChanged(day.date)
        //    dismiss(animated: true, completion: nil)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
}
