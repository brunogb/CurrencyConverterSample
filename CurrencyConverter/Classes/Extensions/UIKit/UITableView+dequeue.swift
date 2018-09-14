//
//  UITableView+dequeue.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension UITableView {

    private static var registeredCellTypesKey = 0
    private var registeredCellTypes: [String] {
        get {
            return objc_getAssociatedObject(self, &UITableView.registeredCellTypesKey) as? [String] ?? []
        }
        set {
            objc_setAssociatedObject(self, &UITableView.registeredCellTypesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func registerIfNeeded(type: UITableViewCell.Type, identifier: String) {
        guard !registeredCellTypes.contains(identifier) else { return }
        register(type, forCellReuseIdentifier: identifier)
        registeredCellTypes.append(identifier)
    }

    func dequeue(type: UITableViewCell.Type, indexPath: IndexPath)-> UITableViewCell {
        let identifier = String(describing: type)
        registerIfNeeded(type: type, identifier: identifier)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }

}
