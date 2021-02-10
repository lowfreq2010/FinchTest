//
//  PersistentStorage.swift
//  CurrencyListFetcher
//
//  Created by VNS Work on 31.01.2021.
//

import Foundation
import UIKit

class ProductListNSUD: NSObject {
    let userDefaults: UserDefaults
    var key: String
    var storedValue: [Product]

    init(with key: String, value: [String]) {
        self.userDefaults = UserDefaults.standard
        self.key = key
        self.storedValue = []
    }
    
    func save() {
        self.userDefaults.setValue(self.storedValue, forKey: key)
    }
    
    func restore() -> [Product] {
        guard let retValue = self.userDefaults.object(forKey: self.key) else {return []}
        return retValue as! [Product]
    }
}


