//
//  UITableView+.swift
//  toDoList
//
//  Created by User on 06.01.2022.
//

import UIKit

extension UITableView {
    
    func registerCellClass(_ typeCell: UITableViewCell.Type) {
        self.register(typeCell, forCellReuseIdentifier: typeCell.identifier)
    }
    
    func registerHeaderClass(_ typeView: UIView.Type) {
        self.register(typeView, forHeaderFooterViewReuseIdentifier: typeView.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
