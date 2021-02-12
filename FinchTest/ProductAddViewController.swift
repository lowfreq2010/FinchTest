//
//  ProductAddViewController.swift
//  FinchTest
//
//  Created by vns on 11.02.2021.
//

import UIKit

class ProductAddViewController: UIViewController {
    
    let productAddViewModel: ProductAddViewModel = ProductAddViewModel(with: ProductAddModel(title: "", description: "", image: ""))

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {

        if self.productAddViewModel.validateFields() {
            performSegue(withIdentifier: "unwindToMain", sender: sender)
        } else {
            self.presentAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProductAddViewController {
    
    func presentAlert() -> Void {
        let alert = UIAlertController(title: "Внимание", message: "Пожалуйста, заполните все поля и выберите фото продукта", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}
