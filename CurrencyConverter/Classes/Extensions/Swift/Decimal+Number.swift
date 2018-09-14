//
//  Decimal+Number.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension Decimal {
    var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
