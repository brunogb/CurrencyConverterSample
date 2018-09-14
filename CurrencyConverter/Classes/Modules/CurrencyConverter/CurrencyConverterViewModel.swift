//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Bruno Gondim Bilescky on 14/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import UIKit

struct CurrencyConverterViewModel {

    let converter: CurrencyConverter
    var selectedCurrency: Currency
    var value: Float

    init(converter: CurrencyConverter, selectedCurrency: Currency? = nil, value: Float? = nil) {
        self.converter = converter
        self.selectedCurrency = selectedCurrency ?? converter.base
        self.value = value ?? 100
    }

    func listViewModel()-> CurrencyListViewModel {
        let selected = currencyViewModel(currency: selectedCurrency, amount: value)
        let list = converter.listOfCurrencies.map { currencyViewModel(currency: $0, amount: value) }
        return .loaded(selected: selected, list: list)
    }

    func currencyViewModel(currency: Currency, amount: Float)-> CurrencyViewModel {
        let viewModel = CurrencyViewModel(currency: currency,
                                          value: converter.convert(to: currency, amount: amount))
        return viewModel
    }

    

}
