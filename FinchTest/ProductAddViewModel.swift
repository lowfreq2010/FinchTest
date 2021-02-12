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
    var productModel: ProductAddModel
    
    
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
}
