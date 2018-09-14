//
//  NumberFormmater+Style.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
        self.currencySymbol = ""
    }
}

extension Formatter {
    static let currency = NumberFormatter(numberStyle: .currency)
}
