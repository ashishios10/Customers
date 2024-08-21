//
//  Customer.swift
//  Customers
//
//

import Foundation

struct Customer: Identifiable, Codable {
    var id: String
    var profileImage: String
    var name: String
    var balance: Int
    var isOverdue: Bool
    
    // MARK: TASK 2
    // 2. Fix the initials method that needs to return the customer's initials.
    func initials() -> String {
        return name.initials
    }
    
    static let example = Customer(id: "example", profileImage: "pencil", name: "Name Surname", balance: 99999, isOverdue: true)
    static let allCustomers = [Customer(id: "1", profileImage: "pencil", name: "Uno Anonimo", balance: 123, isOverdue: true), Customer(id: "2", profileImage: "star", name: "Due Betiucci", balance: 234, isOverdue: false), Customer(id: "3", profileImage: "applelogo", name: "Trois Fromage", balance: 345, isOverdue: true)]
}


extension String {
    var initials: String {
        return self.components(separatedBy: " ")
            .reduce("") {
                ($0.isEmpty ? "" : "\($0.first?.uppercased() ?? "")") +
                ($1.isEmpty ? "" : "\($1.first?.uppercased() ?? "")")
            }
    }
}
