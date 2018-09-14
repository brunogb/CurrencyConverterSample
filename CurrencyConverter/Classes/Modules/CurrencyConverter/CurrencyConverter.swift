//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

struct CurrencyConverter {

    let base: Currency
    private let fxTable: [String: Float]

    private(set) var listOfCurrencies: [Currency] = []

    init(base: Currency, fxTable: [String: Float]) {
        self.base = base
        listOfCurrencies = fxTable.map { Currency(code: $0.key) }
        var baseFxTable = fxTable
        baseFxTable[base.code] = 1
        self.fxTable = baseFxTable
    }

    func convert(to currency: Currency, amount: Float)-> Float {
        let fx = fxTable[currency.code, default: 0]
        return fx * amount
    }

}
