//
//  String+Digits.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class String_Digits: XCTestCase {

    func testNumericStringTranslateToUInt() {
        let given = "1234567"
        let then = given.digits
        XCTAssertEqual(then, [1,2,3,4,5,6,7])
    }

    func testIgnoreOtherCharactersInString() {
        let given = "123a45.67"
        let then = given.digits
        XCTAssertEqual(then, [1,2,3,4,5,6,7])
    }

}
