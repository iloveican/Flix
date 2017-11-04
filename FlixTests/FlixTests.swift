//
//  FlixTests.swift
//  FlixTests
//
//  Created by wc on 05/11/2017.
//  Copyright © 2017 DianQK. All rights reserved.
//

import XCTest
@testable import Flix

class FlixTests: XCTestCase {

    var tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
    
    override func setUp() {
        super.setUp()
        self.tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuild() {
        let uniqueCustomProvider = UniqueCustomTableViewProvider()
        uniqueCustomProvider.itemHeight = { return 100 }
        tableView.flix.build([uniqueCustomProvider])
        let delegate = tableView.delegate!
        XCTAssertEqual(delegate.tableView!(tableView, heightForRowAt: IndexPath(row: 0, section: 0)), 100)
        let dataSource = tableView.dataSource!
        XCTAssertEqual(dataSource.numberOfSections!(in: tableView), 1)
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 1)
        uniqueCustomProvider.isHidden.value = true
        XCTAssertEqual(dataSource.numberOfSections!(in: tableView), 1)
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0)

        let unique2CustomProvider = UniqueCustomTableViewProvider()
        unique2CustomProvider.itemHeight = { return 200 }
        tableView.flix.build([uniqueCustomProvider, unique2CustomProvider])
        XCTAssertEqual(dataSource.numberOfSections!(in: tableView), 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
