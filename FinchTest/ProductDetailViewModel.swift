//
//  ProductDetailViewModel.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import Foundation
import UIKit

class ProductDetailViewModel: NSObject {
    
    private var product: ProductDetail
    
    init(with productDetail: ProductDetail) {
        self.product = productDetail
    }
}
