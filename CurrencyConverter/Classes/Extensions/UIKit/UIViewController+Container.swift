//
//  UIViewController+Container.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension UIViewController {

    public func set(contentController: UIViewController) {
        install(viewController: contentController)
        contentController.view.snapToEdges(of: self.view)
    }

    public func install(viewController: UIViewController) {
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewController.view)
    }

}
