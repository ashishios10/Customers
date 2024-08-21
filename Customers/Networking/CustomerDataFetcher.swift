//
//  CustomerDataFetcher.swift
//  Customers
//
//

import Foundation

struct CustomerDataFetcher {
    var session = URLSession.shared
    // MARK: TASK 3
    // 3. Fix the method so that it fetches the customer data from a given url.
    func getCustomerData(from url: URL) async throws -> Data? {
        //create a new urlRequest passing the url
        let request = URLRequest(url: url)
        
        //run the request and retrieve both the data and the response of the call
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func customersModel(from data: Data?) -> [Customer]? {
        guard let jsonData = data else { return nil }
        let decoder = JSONDecoder()
        let customerModel = try? decoder.decode([Customer].self, from: jsonData)
        
        return customerModel
    }
}
