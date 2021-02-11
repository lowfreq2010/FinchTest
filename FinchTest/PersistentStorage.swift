//
//  PersistentStorage.swift
//  CurrencyListFetcher
//
//  Created by VNS Work on 31.01.2021.
//

import Foundation
import UIKit

class ProductListNSUD: NSObject {
    private let userDefaults: UserDefaults
    public var key: String
    public var storedValue: String = ""

    init(with key: String) {
        self.userDefaults = UserDefaults.standard
        self.key = key
    }
    
    func save() {
        self.userDefaults.setValue(self.storedValue, forKey: self.key)
    }
    
    func restore() -> String {
        guard let retValue = self.userDefaults.object(forKey: self.key) as? String else {return ""}
        return retValue
    }
}


