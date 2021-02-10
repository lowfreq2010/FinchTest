//
//  ProductModel.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import Foundation

struct Product: Codable {
    var title: String
    var description: String
    var image: String
}


class ProductModel {
    
    // MARK: Private properties
    private let nsudProcessor: ProductListNSUD = ProductListNSUD(with: "productList", value: [])
    
//    private var rates: CurrencyRate = [:] //contains all currency/exchange rate pairs
//    private var originalList: [String] = [] // contains all currency codes that existed originally
//    private let jsonFetcher: Fetchable
//    private let jsonProcessor: JSONProcessor = JSONProcessor()
    
    // MARK: Public properties
//    var originalCurrencies: [String] { get { return self.originalList }}
//    var originalRates: CurrencyRate { get { return self.rates }}
    
    // MARK: Class initializers and methods
//    init(with fetcher:Fetchable) {
//        self.jsonFetcher = fetcher
//    }
    
    // fetch all currency data
    func getData(_ completion: @escaping ([Product]) -> ()) {
        // try to restore saved products
        let savedProducts: [Product] = self.nsudProcessor.restore()
        completion(savedProducts)
        
    }
    
    
}

