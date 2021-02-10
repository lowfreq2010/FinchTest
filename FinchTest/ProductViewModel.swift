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
    
    // fetch all currency data
    func getData() {
        // ask model to load data from NSUD and prepare data for view
        self.productModel.getData({[unowned self] productList in
            self.products = productList
            // call binding callback to update the view accordingly
            self.callback()
            
        })
    }
    
    func product(for indexPath: IndexPath) ->Product {
        let row = indexPath.row
        return self.products[row]
    }
    
    func getProductTitle(for indexPath: IndexPath) -> String {
        return self.product(for: indexPath).title
    }
    
    func getProductDescription(for indexPath: IndexPath) -> String {
        return self.product(for: indexPath).description
    }
    
    
//    // return currency code for given row
//    func getCurrency(for row:Int) -> String {
//        return self.currencies[row]
//    }
//
//    // return currency exchange rate for given row
//    func getRate(for row:Int) -> Float {
//        return self.currencyModel.originalRates["\(self.getCurrency(for: row))"]!
//    }
//
//    // return selected currency code for given row
//    func getSelectedCurrency(for row:Int) -> String {
//        return self.selectedCurrencies[row]
//    }
//
//    // return selected currency exchange rate for given row
//    func getSelectedCurrencyRate(for row:Int) -> Float {
//        return self.currencyModel.originalRates["\(self.getSelectedCurrency(for: row))"]!
//    }
//
//
//    func processStar(on indexPath: IndexPath) -> Void {
//        print("Tapped on star in section: \(indexPath.section) row:\(indexPath.row)")
//        let section = indexPath.section
//        let row = indexPath.row
//
//        switch section {
//        case 0: // remove currency from selected list
//            self.removeFromSelected(from: row)
//        case 1: // move currency to selected list
//            self.moveCurrencyToSelected(from: row)
//        default:
//            break
//        }
//        self.nsudProcessor.storedValue = self.selectedCurrencies
//        self.nsudProcessor.save()
//    }
//
//    // MARK: processing append/remove to Selected list
//
//    func moveCurrencyToSelected(from position: Int) -> Void {
//        let currencyName: String = self.getCurrency(for: position)
//        if self.selectedCurrencies.count==5 {
//            let alertController = UIAlertController(title:"", message: NSLocalizedString("NOMORETHAN5", comment: ""), preferredStyle: .alert)
//            let close = UIAlertAction(title: NSLocalizedString("CLOSE", comment: ""), style: UIAlertAction.Style.cancel, handler: nil)
//            alertController.addAction(close)
//            UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true, completion: nil)
//        } else {
//            self.selectedCurrencies.append(currencyName)
//            self.currencies.remove(at: position)
//            print("moving to Selected in row \(position) Currency is \(currencyName)")
//            self.callback()
//        }
//    }
//
//    func removeFromSelected(from position: Int) -> Void {
//
//        self.selectedCurrencies.remove(at: position)
//        self.currencies = subtractSelected()
//        self.callback()
//    }
//
//    func subtractSelected() -> [String] {
//        return self.currencyModel.originalCurrencies.filter { !self.selectedCurrencies.contains($0) } .sorted(by: <)
//    }
    
}
