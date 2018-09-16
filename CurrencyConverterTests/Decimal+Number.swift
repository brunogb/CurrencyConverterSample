//
//  Decimal+Number.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class Decimal_Number: XCTestCase {

    func testDecimalMapsToNSDecimal() {
        let given: Decimal = 1234
        let then = given.number
        XCTAssertEqual(then, NSDecimalNumber(decimal: 1234))
    }

}
