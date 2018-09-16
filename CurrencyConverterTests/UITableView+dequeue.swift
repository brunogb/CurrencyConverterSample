//
//  UITableView+dequeue.swift
//  CurrencyConverterTests
//
//  Created by Bruno Gondim Bilescky on 17/09/2018.
//  Copyright © 2018 Bruno Bilescky. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class UITableView_dequeue: XCTestCase {

    private class DummyDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return tableView.dequeue(type: UITableViewCell.self, indexPath: indexPath)
        }

    }

    private var dataSource: DummyDataSource!

    override func setUp() {
        super.setUp()
        dataSource = DummyDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testExample() {
        let given = UITableView(frame: .zero, style: .plain)
        //then
        given.dataSource = dataSource
        let expected = given.dequeue(type: UITableViewCell.self, indexPath: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(expected)
    }

}
