//
//  CurrencyConverterServiceTests.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 16/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterServiceTests: XCTestCase {

    private class DummyRequester: Requester {

        func request<R>(resource: JSONResource<R>, callback: @escaping (Result<R>) -> Void) -> RequestToken? where R : Decodable {
            let result: Result<R> = .success(expectedResult as! R)
            callback(result)
            return nil
        }

        var expectedResult: Decodable!

    }

    private var requester: DummyRequester!

    override func setUp() {
        requester = DummyRequester()
    }

    override func tearDown() {
        requester = nil
    }

    func testServiceBuildsConverter() {
        requester.expectedResult = CurrencyConverterListResponse(base: "EUR", date: Date(), rates: ["GBP":1])
        let given = URLCurrencyConverterService(requester: requester)
        given.requestUpdates(for: "EUR") { (result) in
            guard case let .success(converter) = result else {
                return XCTFail("failed to get converter")
            }
            XCTAssertEqual(converter.base.code, "EUR")
            XCTAssertEqual(converter.listOfCurrencies.count, 2)
        }
    }

}
