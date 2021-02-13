//
//  ProductAddViewController.swift
//  FinchTest
//
//  Created by vns on 11.02.2021.
//

import UIKit

class ProductAddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let productAddViewModel: ProductAddViewModel = ProductAddViewModel(with: ProductAddModel(title: "", description: "", image: ""))
    var isViewMovedUp: Bool = false

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {

        if self.productAddViewModel.validateFields() {
            self.productAddViewModel.save()
            performSegue(withIdentifier: "unwindToMain", sender: sender)
        } else {
            self.presentAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDismissGestureRecognizer()
        self.productTitle.delegate = self
        self.productDescription.delegate = self
    }
    
    //MARK: TextField/TextView delegate functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 200)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 200)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        animateViewMoving(up: true, moveValue: 200)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: true, moveValue: 200)
    }
}

extension ProductAddViewController {
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        if (self.isViewMovedUp && up) {
            return
        }
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.animate(withDuration: movementDuration) {
            self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        }
        self.isViewMovedUp = up
    }
    
    func presentAlert() -> Void {
        let alert = UIAlertController(title: "Внимание", message: "Пожалуйста, заполните все поля и выберите фото продукта", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setupDismissGestureRecognizer () -> Void {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
}
