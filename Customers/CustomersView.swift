//
//  ContentView.swift
//  Customers
//
//

import SwiftUI

struct CustomersView: View {
    @StateObject var customers = CustomersViewModel()

    var body: some View {
        VStack {
            List (customers.onlyOverdue ? customers.customersOverdue : customers.customers) { customer in
                CustomerListView(customer: customer)
            }
            .refreshable {
                await customers.getCustomers()
            }
            
            HStack(alignment: .top, spacing: 20) {
                Toggle (isOn: $customers.onlyOverdue) {
                    Text("Overdue")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Button("Get Customers") {
                    Task {
                        await customers.getCustomers()
                    }
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}
