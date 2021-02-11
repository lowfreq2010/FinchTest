//
//  ProductDetailViewModel.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import Foundation
import UIKit

class ProductDetailViewModel: NSObject {
    
    var callback: () -> () = {} //binding callback for refreshing view with new data 
    
    var productTitle: String = ""
    var productDescription: String = ""
    var productImage: String = ""
    
    
}
