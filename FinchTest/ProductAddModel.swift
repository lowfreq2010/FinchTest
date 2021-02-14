//
//  ProductAddModel.swift
//  FinchTest
//
//  Created by VNS Work on 11.02.2021.
//

import Foundation

struct ProductAddModel {
    var title: String = "" {
        didSet {
            validateInput()
        }
    }
    var description: String = "" {
        didSet {
            validateInput()
        }
    }
    var image: String = "" {
        didSet {
            validateInput()
        }
    }
    var dataValidationCallback: ((Bool) -> ())? = nil

    var isDataValid: Bool? {
        didSet {
            if oldValue != isDataValid {
                guard let dataValidationCallback = dataValidationCallback else {return}
                dataValidationCallback(isDataValid ?? false)
            }
        }
    }
}

extension ProductAddModel {
    
    mutating func validateInput() {
        let trimmedData = [title, description, image].map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        let charsCount = trimmedData.reduce(0, {(result: Int, nextItem: String) -> Int in result + nextItem.count})
        self.isDataValid = (charsCount == 0) ? true : false
    }
}

