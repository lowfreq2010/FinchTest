//
//  ProductAddModel.swift
//  FinchTest
//
//  Created by VNS Work on 11.02.2021.
//

import Foundation

struct ProductAdd {
    var title: String
    var description: String
    var image: String
}

extension ProductAdd {
    func isAllEmpty() -> Bool {
        var retVal  = true
        let checkString: String = self.title + self.description + self.image
        if checkString == "" {
            retVal = false
        }
        return retVal
    }
}

