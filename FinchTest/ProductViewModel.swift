//
//  ProductViewModel.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import Foundation
import UIKit

protocol ProductListViewModelProtocol {
    // func processStar(on indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfRows(for section:Int) -> Int
    func getTitle(for section:Int) -> String?
    
}

class ProductListViewModel: ProductListViewModelProtocol {
    
    private var products: [Product] = []
    private let productModel: ProductModel
    
    var callback: () -> () = {} //binding callback for refreshing view with new data
    var selectedRow: Int  = 0
    
    init(with model: ProductModel ) {
        self.productModel = model
    }
    
    // MARK: Service class objects
    
    // MARK: UITableview delegate/source
    func numberOfSections()->Int {
        // return self.selectedCurrencies.count == 0 ? 1 : 2
        return 1
    }
    
    func numberOfRows(for section:Int)->Int {
        return self.products.count
    }
    
    func getTitle(for section:Int) -> String? {
        var title: String
        
        switch section {
        case 1:
            title = NSLocalizedString("COMMONLIST", comment: "")
        default:
            title = ""
        }
        return title
    }
    
    // MARK: Convenience methods
    
    // fetch all product data
    func getData() {
        // ask model to load data from NSUD and prepare data for view
        self.productModel.getData({[unowned self] productList in
            // decode json to array of products
            
            self.products = self.decodeJSON(from: productList)
            // call binding callback to update the view accordingly
            self.callback()
            
        })
    }
    
    private func product(for indexPath: IndexPath) ->Product {
        let row = indexPath.row
        return self.products[row]
    }
    
    public func getProductTitle(for indexPath: IndexPath) -> String {
        return self.product(for: indexPath).title
    }
    
    public func getProductDescription(for indexPath: IndexPath) -> String {
        return self.product(for: indexPath).description
    }
    
    public func getProductImageName(for indexPath: IndexPath) -> String? {
        return self.product(for: indexPath).image
    }
    
    public func deleteProduct(for row: Int) -> Void {
        if row < self.products.count {
            
            self.products.remove(at: row)
            let dicArray = self.products.map { $0.convertToDictionary() }
            let encodedJSON = self.convertToJSONString(value: dicArray)
            self.productModel.saveData(with: encodedJSON ?? "")
            self.callback()
        }
    }
    
    private func convertToJSONString(value: Any) -> String? {
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch{
            }
        }
        return nil
    }
    
    private func decodeJSON(from json: String) -> [Product] {
        var result: [Product] = [Product(title: "test", description: "test", image: "test")]
        if let productsData = json.data(using: .utf8),
           let productsArray: [Product] = try? JSONDecoder().decode([Product].self, from: productsData) {
            result = productsArray
        }
        return result
    }
}
