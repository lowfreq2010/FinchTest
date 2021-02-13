//
//  ImageService.swift
//  FinchTest
//
//  Created by vns on 13.02.2021.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

class ImageService: NSObject {
    
    func drawRectangle(with width:Int, height: Int) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))

        let img =  renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: width, height: height)

            ctx.cgContext.setFillColor(UIColor.random.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.random.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        return img
    }
    
    func saveImage(from image: UIImage?, to filename: String) -> Void {
        
        guard let image = image else {return}
        let imageData = image.pngData()
        let filename = getDocumentsDirectory().appendingPathComponent("\(filename).png")
        try? imageData?.write(to: filename)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func generateRandomImage(with name: String, width: Int, height: Int) -> Void {
        
        let image: UIImage? = self.drawRectangle(with: width, height: height)
        saveImage(from: image, to: name)

    }
    
    func getImageFromDocuments(by name: String) ->UIImage? {
        
        let documentPath = getDocumentsDirectory()
        let imageURL = URL(fileURLWithPath: documentPath.absoluteString).appendingPathComponent("\(name).png")
        let image    = UIImage(contentsOfFile: imageURL.path)
        
        return image
    }
}
