//
//  ProductAddModel.swift
//  FinchTest
//
//  Created by VNS Work on 11.02.2021.
//

import Foundation

struct ProductAddModel {
    var title: String
    var description: String
    var image: String
}

extension ProductAddModel {
    func isAllEmpty() -> Bool {
        var retVal  = false
        let checkString: String = self.title.trimmingCharacters(in: .whitespacesAndNewlines) + self.description.trimmingCharacters(in: .whitespacesAndNewlines) + self.image.trimmingCharacters(in: .whitespacesAndNewlines)
        if checkString == "" {
            retVal = true
        }
        return retVal
    }
}

