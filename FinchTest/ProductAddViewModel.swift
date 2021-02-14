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
    private var productModel: ProductAddModel = ProductAddModel()
    var isDataValid: Bool = false
    
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
    
    func initModel() {
        self.productModel = ProductAddModel(title: "", description: "", image: "", dataValidationCallback: {[weak self] state in  self?.isDataValid = state}, isDataValid: false)
    }

    func save() -> Void {
        //TODO: pass all values to model and let it care abount actual saving
        print("save all values in model")
        
    }
}
