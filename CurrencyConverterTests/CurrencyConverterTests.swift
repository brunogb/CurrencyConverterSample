//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    var converter: CurrencyConverter!
    var eur: Currency!
    var gbp: Currency!
    var brl: Currency!
    var usd: Currency!
    var fx: [String: Double]!

    override func setUp() {
        eur = Currency(code: "EUR")
        brl = Currency(code: "BRL")
        gbp = Currency(code: "GBP")
        usd = Currency(code: "USD")
        fx = [gbp.code: 0.90, brl.code: 0.2, usd.code: 0.95]
    }

    override func tearDown() {
        eur = nil
        brl = nil
        gbp = nil
        usd = nil
        fx = nil
    }

    func testConvertFromEURToGBP() {
        let given = CurrencyConverter(base: eur, fxTable: fx)
        let then = given.convert(to: gbp, amount: 1)
        XCTAssertEqual(then, 0.9)
    }

    func testConvertGBPtoBRL() {
        let given = CurrencyConverter(base: eur, current: gbp, fxTable: fx)
        let then = given.convert(to: brl, amount: 1)
        XCTAssertGreaterThan(then, 0.22)
        XCTAssertLessThan(then, 0.23)
    }

}
