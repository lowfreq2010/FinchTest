//
//  ProductModel.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import Foundation

struct Product: Codable, Equatable {
    var title: String
    var description: String
    var image: String
}

extension Product {
    func convertToDictionary() -> [String : Any] {
        let dic: [String: Any] = ["title":self.title, "description":self.description, "image": self.image]
        return dic
    }
}


class ProductModel {
    
    // MARK: Private properties
    private let nsudProcessor: ProductListNSUD = ProductListNSUD(with: "productList")

    // MARK: Public properties
    
    // MARK: Class initializers and methods
    // fetch all data
    func getData(_ completion: @escaping (String) -> ()) {
        // try to restore saved products
        guard let restoredData = self.nsudProcessor.restore() else { return}
        completion(restoredData)
    }
    
    func generateTestData() -> String {
        
        let testJSON = "[{\"title\":\"Продукт 1\",\"image\":\"image1\",\"description\":\"aslifhasifshja.isfjaslifjsalifjlsaijflsijaflksajflksajflksaj\"},{\"title\":\"Продукт 2\",\"description\":\"zx,jxvz,gdsigdsogoesglsslslsfjdslgfjdsljgfdljhgfldld\",\"image\":\"image2\"},{\"title\":\"Продукт 3\",\"image\":\"image3\",\"description\":\"sgdwdgdsgdsgdsgddsgsdgdsgdsgs\"},{\"title\":\"Продукт 4\",\"image\":\"image4\",\"description\":\"sgdwdgdsgdsgdsgddsgsdgdsgdsgs\"},{\"title\":\"Продукт 5\",\"image\":\"image5\",\"description\":\"sgdwdgdsgdsgdsgddsgsdgdsgdsgs\"}]"
        
        for n in 1...5 {
            ImageService.generateRandomImage(with: "image\(n)", width: 512, height: 512)
        }
        return testJSON
        
    }
    
    func saveData(with value: String) -> Void {
        self.nsudProcessor.storedValue = value
        try? self.nsudProcessor.save()
    }
}

