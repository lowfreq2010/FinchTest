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
        let trimmedData: [String] = [title, description, image].map({$0.trimmingCharacters(in: .whitespacesAndNewlines)})
        let counts: [Bool] = trimmedData
            .map({$0.count})
            .map({$0>0})
        guard let firstVal = counts.first else {return}
        self.isDataValid = counts.reduce(firstVal, {(result: Bool, nextItem: Bool) -> Bool in result && nextItem})
    }
}

