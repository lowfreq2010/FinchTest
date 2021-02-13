//
//  ProductDetailTableViewController.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    var productDetailViewModel: ProductDetailViewModel = ProductDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        
        self.productTitle.text = self.productDetailViewModel.productTitle
        self.productDescription.text = self.productDetailViewModel.productDescription
        self.productImage.image = ImageService.getImageFromDocuments(by: self.productDetailViewModel.productImage)
        
    }
}
