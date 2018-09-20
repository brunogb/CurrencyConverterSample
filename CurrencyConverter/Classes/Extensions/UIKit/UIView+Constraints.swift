//
//  UIView+Constraints.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

public protocol EdgeLayoutable {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
}

public protocol CenterLayoutable {
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: EdgeLayoutable, CenterLayoutable { }
extension UILayoutGuide: EdgeLayoutable, CenterLayoutable { }


extension UIView {

    public func snapToEdges(of layoutable: EdgeLayoutable, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: layoutable.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: layoutable.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: layoutable.trailingAnchor, constant: -insets.right),
            self.bottomAnchor.constraint(equalTo: layoutable.bottomAnchor, constant: -insets.bottom)
            ])
    }

    public func centerIn(_ layoutable: CenterLayoutable, offset: CGPoint = .zero) {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: layoutable.centerXAnchor, constant: offset.x),
            self.centerYAnchor.constraint(equalTo: layoutable.centerYAnchor, constant: offset.y)
        ])
    }

}
