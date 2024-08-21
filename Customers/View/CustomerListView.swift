//
//  CustomerListView.swift
//  Customers
//
//

import SwiftUI

struct CustomerListView: View {
    let customer: Customer
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(customer.initials())
                .font(.title)
                .frame(width: 50, height: 50, alignment: .center)
                .padding()
                .overlay(Circle().stroke(Color.black, lineWidth: 3))
            VStack(alignment: .leading) {
                Text(customer.name)
                    .font(.title)
                Text("\(customer.balance)")
                // MARK: TASK 1
                // 1. Add an 'overdue' label to this cell which should be displayed only if the customer's account is overdue.
                if customer.isOverdue {
                    Label("overdue", systemImage: customer.profileImage)
                }
            }
        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView(customer: Customer.example)
    }
}
