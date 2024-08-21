//
//  CustomersTests.swift
//  CustomersTests
//
//

import XCTest
@testable import Customers

class CustomersTests: XCTestCase {
    var viewModel: CustomersViewModel!
    
    override func setUpWithError() throws {
        viewModel = CustomersViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testCustomersViewModel_getCustomers() async throws {
        XCTAssertEqual(viewModel.customers.count, 3)
        await viewModel.getCustomers()
        XCTAssertEqual(viewModel.customers.count, 10)
    }
    
    func testCustomersViewModel_filterOverdue() throws {
        let filtered = viewModel.filterOverdue(customers: Customer.allCustomers)
        
        XCTAssertEqual(filtered.count, 2)
    }
    
    func testCustomersViewModel_filterOverdueFetchedTen() async throws {
        await viewModel.getCustomers()
        let filtered = viewModel.customersOverdue
        
        XCTAssertEqual(filtered.count, 5)
    }
    
    func testCustomerViewModel_getRandomUrl_alternates() {
        let link = viewModel.getRandomUrl()
        viewModel.firstLink = false
        let link2 = viewModel.getRandomUrl()
        XCTAssertEqual(link.absoluteString, "https://verbenyi.com/customers.json")
        XCTAssertEqual(link2.absoluteString, "https://verbenyi.com/customers-full.json")
    }
    
    // MARK:- Customer Model Test
    func testCustomerInitials() {
        let customer = Customer.example
        
        XCTAssertEqual(customer.initials(), "NS")
    }
    
    func testCustomerInitials_multipleCustomers() {
        let customers = Customer.allCustomers
        let initials = ["UA", "DB", "TF"]
        
        for (index, customer) in customers.enumerated() {
            XCTAssertEqual(customer.initials(), initials[index])
        }
    }
}
