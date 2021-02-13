//
//  ProductListViewController.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import UIKit

class ProductListViewController: UITableViewController {
    
    var productListViewModel: ProductListViewModel? {
        didSet {
            self.productList.reloadData()
        }
    }
    
    var callback: () ->() = {}
    
    @IBOutlet weak var productList: UITableView!
    
    //MARK: View Controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register custom cells with tableview
        let nibCell :UINib = UINib(nibName: "ProductTableviewCell", bundle: nil)
        self.productList
            .register(nibCell, forCellReuseIdentifier: "productCell")
        
        //set viewModel
        self.productListViewModel = ProductListViewModel(with: ProductModel())
        // bind tableview to updates in ViewModel
        self.callback = { [weak self] in
            DispatchQueue.main.async {
                self?.productList.reloadData()
            }
        }
        self.productListViewModel?.callback = self.callback
        
        // start asynchronous fetch of saved data
        self.productListViewModel?.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.productList.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.productListViewModel?.numberOfSections() ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productListViewModel?.numberOfRows(for: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.productList.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableviewCell else {return UITableViewCell()}
        
        // cell.configureShadow()
        cell.productTitle.text = self.productListViewModel?.getProductTitle(for: indexPath)
        cell.productDescription.text = self.productListViewModel?.getProductDescription(for: indexPath)
        let imageName = self.productListViewModel?.getProductImageName(for: indexPath)
        cell.productImage.image = ImageService.getImageFromDocuments(by: imageName ?? "image\(indexPath.row)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
        cell.contentView.layer.masksToBounds = true
    }
    
    
    
    //MARK: Table View editing (delete/insert rows)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the row from the data source
            self.productListViewModel?.deleteProduct(for:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProductDetail", sender: indexPath)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "toProductDetail":
            self.openDetail(with: segue, sender: sender)
        case "toProductAdd":
            self.addProduct(with: segue, sender: sender)
        case "unwindToMain":
            print("unwinded back")
        default: break
        }
    }
}


extension ProductListViewController {
    
    func openDetail(with segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! ProductDetailViewController
            // pass selected product to Detail ModelView
            if (sender is IndexPath) {
                let sentobject = sender as? IndexPath ?? IndexPath()
                vc.productDetailViewModel.productTitle = self.productListViewModel?.getProductTitle(for: sentobject ) ?? ""
                vc.productDetailViewModel.productDescription = self.productListViewModel?.getProductDescription(for: sentobject) ?? ""
                vc.productDetailViewModel.productImage = self.productListViewModel?.getProductImageName(for: sentobject) ?? "image1"
            }
    }
    
    
    func addProduct(with segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! ProductAddViewController
            if (sender is IndexPath) {
                //let sentobject = sender as? IndexPath
            }
    }
    
    // Unwind segue marker
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    
    
    
    
    
}
