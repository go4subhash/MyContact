//
//  UITabbleView+Ext.swift
//  MyContactApp
//
//  Created by Subhash on 22/10/19.
//  Copyright © 2019 Subhash. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {

    private func register<T: UITableViewCell>(cell: T.Type) {
        let nibName = cell.nibName
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    func register<T: UITableViewCell>(with cells: [T.Type]) {

        cells.forEach { cell in
            register(cell: cell)
        }
    }

    func removeNoRecordView() {
        backgroundView = nil
    }

    func updateHeaderViewHeight() {
        guard let headerView = tableHeaderView
        else { return }
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        tableHeaderView = headerView
    }

    func getTableHeaderHeight(_ tableView: UITableView) -> CGFloat {
        if let headerView = tableView.tableHeaderView {

            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            return height
        }
        return 0
    }
}



