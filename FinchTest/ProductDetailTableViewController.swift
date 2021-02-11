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
    var callback: () ->() = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callback = { [unowned self] in
            DispatchQueue.main.async {
                self.configureView()
            }
        }
        self.productDetailViewModel.callback = self.callback

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func configureView() {
        
        self.productTitle.text = self.productDetailViewModel.productTitle
        self.productDescription.text = self.productDetailViewModel.productDescription
        
    }



}
