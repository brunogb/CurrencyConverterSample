//
//  CurrencyListViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 17/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyListViewModelTests: XCTestCase {

    var eurCurrencyModel: CurrencyViewModel!
    var gbpCurrencyModel: CurrencyViewModel!
    var brlCurrencyModel: CurrencyViewModel!

    override func setUp() {
        super.setUp()
        eurCurrencyModel = CurrencyViewModel(currency: Currency(code: "EUR"), value: 1, editable: true)
        gbpCurrencyModel = CurrencyViewModel(currency: Currency(code: "GBP"), value: 0.9, editable: false)
        brlCurrencyModel = CurrencyViewModel(currency: Currency(code: "BRL"), value: 0.2, editable: false)
    }

    override func tearDown() {
        eurCurrencyModel = nil
        gbpCurrencyModel = nil
        brlCurrencyModel = nil
        super.tearDown()
    }

    func testLoadedValues() {
        let given = CurrencyListViewModel.loaded(selected: eurCurrencyModel, list: [gbpCurrencyModel, brlCurrencyModel])
        let givenPath = IndexPath(row: 0, section: CurrencyListTableSection.principal.rawValue)
        XCTAssertEqual(given.currency, eurCurrencyModel.currency)
        XCTAssertEqual(given.otherCurrencies.map { $0.currency }, [gbpCurrencyModel.currency, brlCurrencyModel.currency])
        XCTAssertEqual(given.numberOfSections, 2)
        XCTAssertEqual(given.numberOfRows(in: CurrencyListTableSection.principal.rawValue), 1)
        XCTAssertEqual(given.numberOfRows(in: CurrencyListTableSection.others.rawValue), 2)
        XCTAssertEqual(given.currencyViewModel(for: givenPath)?.currency, eurCurrencyModel.currency)
        XCTAssertEqual(given.index(for: gbpCurrencyModel.currency), 0)
        XCTAssertEqual(String(describing: given.cellType()), String(describing: CurrencyDisplayTableViewCell.self))
    }

}
