//
//  ProductAddViewModel.swift
//  FinchTest
//
//  Created by VNS Work on 12.02.2021.
//

import Foundation

import Foundation
import UIKit

class ProductAddViewModel: NSObject {
    private var productModel: ProductAddModel
    
    var productTitle: String {
        get {
            return self.productModel.title
        }
        set {
            self.productModel.title = newValue
        }
    }
    
    var productDescription: String {
        get {
            return self.productModel.description
        }
        set {
            self.productModel.description = newValue
        }
    }
    
    var productImage: String {
        get {
            return self.productModel.image
        }
        set {
            self.productModel.image = newValue
        }
    }
    
    init(with model:ProductAddModel) {
        self.productModel = model
    }
    
    
    func validateFields() -> Bool {
        var retVal = true
        if self.productModel.isAllEmpty() {
            retVal = false
        }
        return retVal
    }
    
    func save() -> Void {
        //TODO: pass all values to model and let it care abount actual saving
        
    }
}
