//
//  String+Digits.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

extension String {
    var digits: [UInt8] {
        return map(String.init).compactMap(UInt8.init)
    }
}

