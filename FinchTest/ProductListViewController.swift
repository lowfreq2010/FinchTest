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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register custom cells with tableview
        let nibCell :UINib = UINib(nibName: "ProductTableviewCell", bundle: nil)
        self.productList
            .register(nibCell, forCellReuseIdentifier: "productCell")
        
        //set viewModel
        self.productListViewModel = ProductListViewModel(with: ProductModel())
        // bind tableview to updates in ViewModel
        self.callback = { [unowned self] in
            DispatchQueue.main.async {
                self.productList.reloadData()
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
        // #warning Incomplete implementation, return the number of sections
        return self.productListViewModel?.numberOfSections() ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.productListViewModel?.numberOfRows(for: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.productList.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableviewCell else {return UITableViewCell()}
        
        cell.productTitle.text = self.productListViewModel?.getProductTitle(for: indexPath)
        cell.productDescription.text = self.productListViewModel?.getProductDescription(for: indexPath)

        //self.productListViewModel?.product(for: indexPath)
//        let section = indexPath.section
//        let row  = indexPath.row
//        var string1,string2 :String , buttonColor = UIColor.label
        
//        switch section {
//        case 0:
//            string1 = self.currencyListViewModel?.getSelectedCurrency(for: row) ?? ""
//            string2 = String(self.currencyListViewModel?.getSelectedCurrencyRate(for: row) ?? 0)
//            buttonColor = .systemRed
//        case 1:
//            string1 = self.currencyListViewModel?.getCurrency(for: row) ?? ""
//            string2 = String(self.currencyListViewModel?.getRate(for: row) ?? 0)
//
//        default:
//            return UITableViewCell()
//        }
//
//        // setup closure to be called on Star button tap
//        cell.selectCurrencyButtonAction = { [unowned self] in
//            self.currencyListViewModel?.processStar(on: indexPath)
//        }
//
//        cell.currencyLabel.text = string1 + " - \(string2)"
//        cell.selectCurrency.setTitleColor(buttonColor, for: .normal)
        
        return cell
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
