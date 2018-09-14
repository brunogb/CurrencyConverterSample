//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

struct Currency: Equatable {

    private static var currencyNames: [String: String] = [:]

    let code: String
    let name: String

    init(code: String) {
        self.code = code
        self.name = Currency.currencyNames[code, default: Locale.current.localizedString(forCurrencyCode: code) ?? code]
    }

}
