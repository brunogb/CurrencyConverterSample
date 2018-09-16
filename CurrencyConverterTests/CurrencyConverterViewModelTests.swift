//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterViewModelTests: XCTestCase {

    var converter: CurrencyConverter!
    var selectedCurrency: Currency!

    override func setUp() {
        let eur = Currency(code: "EUR")
        let fx: [String: Double] = ["GBP":0.95, "BRL":0.20]
        converter = CurrencyConverter(base: eur, fxTable: fx)
        selectedCurrency = converter.current
    }

    override func tearDown() {
        converter = nil
        selectedCurrency = nil
    }

    func testCreatingCurrencyListViewModel() {
        let given = CurrencyConverterViewModel(converter: converter, value: 1)
        let then = given.listViewModel()
        guard case let .loaded(selected, others) = then else {
            return XCTFail("failed to create right state")
        }
        XCTAssertEqual(selected.currency, selectedCurrency)
        XCTAssertEqual(others.count, 2)
        XCTAssertEqual(others.first(where: { $0.currency.code == "BRL"})?.value, 0.2)
        XCTAssertEqual(others.first(where: { $0.currency.code == "GBP"})?.value, 0.95)
    }

}
