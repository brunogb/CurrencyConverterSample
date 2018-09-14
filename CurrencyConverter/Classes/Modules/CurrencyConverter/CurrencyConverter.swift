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
    let current: Currency
    private let fxTable: [String: Float]

    private(set) var listOfCurrencies: [Currency] = []

    init(base: Currency, current: Currency? = nil, fxTable: [String: Float]) {
        self.base = base
        self.current = current ?? base
        var baseFxTable = fxTable
        baseFxTable[base.code] = 1
        listOfCurrencies = baseFxTable.map { Currency(code: $0.key) }
        self.fxTable = baseFxTable
    }

    func converterChangingCurrent(currency: Currency)-> CurrencyConverter {
        return CurrencyConverter(base: base, current: currency, fxTable: fxTable)
    }

    func convert(to currency: Currency, amount: Float)-> Float {
        let baseToCurrentFx = fxTable[current.code, default: 0]
        let baseToCurrencyFx = fxTable[currency.code, default: 0]
        let baseConverted = amount * baseToCurrencyFx
        let currentConverted = baseConverted / baseToCurrentFx
        return currentConverted
    }

}
