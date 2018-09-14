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
    var value: Double

    init(converter: CurrencyConverter, selectedCurrency: Currency? = nil, value: Double? = nil) {
        self.converter = converter
        self.selectedCurrency = selectedCurrency ?? converter.base
        self.value = value ?? 100
    }

    func listViewModel()-> CurrencyListViewModel {
        let selected = currencyViewModel(currency: selectedCurrency, amount: value, editable: true)
        let list: [CurrencyViewModel] = converter.listOfCurrencies.compactMap {
            guard $0.code != selectedCurrency.code else { return nil }
            return currencyViewModel(currency: $0, amount: value, editable: false)
        }
        return .loaded(selected: selected, list: list)
    }

    func currencyViewModel(currency: Currency, amount: Double, editable: Bool)-> CurrencyViewModel {
        let viewModel = CurrencyViewModel(currency: currency,
                                          value: converter.convert(to: currency, amount: amount),
                                          editable: editable)
        return viewModel
    }

    

}
