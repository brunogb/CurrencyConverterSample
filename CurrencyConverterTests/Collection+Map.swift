//
//  Collection+Map.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class Collection_Map: XCTestCase {

    func testNumbersMapToString() {
        let given: [UInt8] = [1,2,3,4,5,6]
        let then = given.string
        XCTAssertEqual(then, "123456")
    }

    func testNumbersMapToDecimal() {
        let given: [UInt8] = [1,2,3,4]
        let then = given.decimal
        XCTAssertEqual(then, Decimal(1234))
    }

}
