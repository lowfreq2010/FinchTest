//
//  PersistentStorage.swift
//
//  Created by VNS Work on 31.01.2021.
//

import Foundation
import UIKit


typealias Storeable = String

protocol PersistentStoreable: class {
    var storeObj: Any? {get}
    func save() throws
    func restore() -> Storeable?
}

final class ProductListNSUD: PersistentStoreable {

    var storeObj: Any?
    public var key: String
    public var storedValue: String = ""

    init(with key: String) {
        self.storeObj = UserDefaults.standard
        self.key = key
    }
    
    func save() throws {
        guard let store = self.storeObj as? UserDefaults else {return}
        store.setValue(self.storedValue, forKey: self.key)
    }
    
    func restore() -> Storeable? {
        guard let store = self.storeObj as? UserDefaults else {return ""}
        guard let retValue = store.object(forKey: self.key) as? String else {return ""}
        return retValue
    }
}


