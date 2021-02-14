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
            
            self.decodeJSON(from: productList)
            // call binding callback to update the view accordingly
            self.callback()
            
        })
    }
    
    private func product(for indexPath: IndexPath) ->Product {
        let row = indexPath.row
        return self.products[row]
    }
    
    private func saveProducts() -> Void {
        let dicArray = self.products.map { $0.convertToDictionary() }
        let encodedJSON = self.convertToJSONString(value: dicArray)
        self.productModel.saveData(with: encodedJSON ?? "")
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
            self.saveProducts()
            self.callback()
        }
    }
    
    public func addProduct(_ newProduct: [String]) -> Void {
        // append new product to ViewModel
        let product = Product(title: newProduct[0], description: newProduct[1], image: newProduct[2])
        ImageService.copyImageFromTemp(by: product.image)
        self.products.append(product)
        self.saveProducts()
        self.callback()
        
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
    
    private func decodeJSON(from json: String)  {
        if let productsData = json.data(using: .utf8),
           let productsArray: [Product] = try? JSONDecoder().decode([Product].self, from: productsData) {
            self.products = productsArray
        }
    }
}
