//
//  CustomersUITests.swift
//  CustomersUITests
//
//

import XCTest

class CustomersUITests: XCTestCase {
    var app: XCUIApplication!
    var customerListCells: XCUIElementQuery!
    var getCustomersButton: XCUIElement!
    var overdueToggle: XCUIElement!
    

    override func setUpWithError() throws {
        app = XCUIApplication()
        customerListCells = app.tables.cells
        getCustomersButton = app.buttons["Get Customers"]
        overdueToggle = app.switches.firstMatch
        
        app.launch()
    }

    override func tearDownWithError() throws {
        overdueToggle = nil
        getCustomersButton = nil
        customerListCells = nil
        app = nil
    }
    
    func testInitialsExists() {
        let initials = app.staticTexts["UA"]
        XCTAssertTrue(initials.exists)
    }
    
    func testOverdueLabelShown_onFirstCustomer() {
        let firstCell = customerListCells.firstMatch
        let overdue = firstCell.staticTexts["overdue"]
        XCTAssertTrue(overdue.exists)
    }

    func testListShowsCustomers_defaultThreeRows() {
        XCTAssertEqual(customerListCells.count, 3)
     }
    
    func testGetCustomersButton_listUpdates() {
        XCTAssertEqual(customerListCells.count, 3)
        getCustomersButton.tap()
        _ = customerListCells.element.waitForExistence(timeout: 3)
        XCTAssertEqual(customerListCells.count, 10)
    }
    
    func testOverdue_togglesOnlyOverdueCustomers() {
        XCTAssertEqual(customerListCells.count, 3)
        
        overdueToggle.tap()
        _ = customerListCells.element.waitForExistence(timeout: 1)
        XCTAssertEqual(customerListCells.count, 2)
    }
    
    func testOverdue_togglesOnlyOverdueCustomers_forFetchedCustomerData() {
        XCTAssertEqual(customerListCells.count, 3)
        overdueToggle.tap()
        _ = customerListCells.element.waitForExistence(timeout: 2)
        XCTAssertEqual(customerListCells.count, 2)
        overdueToggle.tap()
        
        getCustomersButton.tap()
        _ = customerListCells.element.waitForExistence(timeout: 2)
        XCTAssertEqual(customerListCells.count, 10)
        overdueToggle.tap()
        _ = customerListCells.element.waitForExistence(timeout: 3)
        XCTAssertEqual(customerListCells.count, 5)
    }
}
