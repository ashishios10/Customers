//
//  CustomersViewModel.swift
//  Customers
//
//

import SwiftUI

class CustomersViewModel: ObservableObject {
    // MARK: TASK 4
    // 4. Currently the customers list is only showing one customer fix the default value of customers so that it shows the default 3 customers from the Customer model (`Model -> Customer.swift`)
    @Published var customers = Customer.allCustomers
    var customersOverdue: [Customer] {
        return filterOverdue(customers: customers)
    }
    @Published var onlyOverdue = false
    
    var firstLink = true
    
    enum db: String {
        case first = "https://verbenyi.com/customers.json"
        case second = "https://verbenyi.com/customers-full.json"
        
        func callAsFunction() -> String {
            return self.rawValue
        }
    }
    // MARK: TASK 5
    // Fix the method to always alternate between the the two links in the `db` Enum. When calling getRandomUrl it should return the URL for the string value of db.first if `firstLink` is true and the db.second if `firstLink` is false.
    func getRandomUrl() -> URL {
        let urlString = firstLink ? db.first() : db.second()
        let url = URL(string: urlString)!
        return url
    }
    
    @MainActor
    func getCustomers() async {
        let customerDataFetcher = CustomerDataFetcher()
        let url = getRandomUrl()
        let customerData = try? await customerDataFetcher.getCustomerData(from: url)
        let customersModel = customerDataFetcher.customersModel(from: customerData)
        guard let customers = customersModel else { return }
        self.customers = customers
    }
    
    // MARK: TASK 6
    // Fix the method so that it only returns customers that are overdue.
    func filterOverdue(customers: [Customer]) -> [Customer] {
        return customers.filter({ $0.isOverdue })
    }
}
