//
//  ProductAddViewController.swift
//  FinchTest
//
//  Created by vns on 11.02.2021.
//

import UIKit

final class ProductAddViewController: UIViewController {
    var statusBarOrientation: UIInterfaceOrientation? {
        get {
            guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {return nil}
            return orientation
        }
    }
    
    var productAddViewModel: ProductAddViewModel? = nil
    
    var isViewMovedUp: Bool = false

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UITextField! {
        didSet {
            productTitle.delegate = self
        }
    }
    @IBOutlet weak var productDescription: UITextView! {
        didSet {
            productDescription.layer.cornerRadius = 5
            productDescription.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            productDescription.layer.borderWidth = 0.5
            productDescription.clipsToBounds = true
            productDescription.delegate = self
        }
    }
    
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {
        
        guard let isDataValid = self.productAddViewModel?.isDataValid else {return}
        if isDataValid {
            self.productAddViewModel?.save()
            performSegue(withIdentifier: "unwindToMain", sender: sender)
        } else {
            self.presentAlert()
        }
    }
    
    @IBAction func producttitleChanged(_ sender: UITextField) {
        self.productAddViewModel?.productTitle = sender.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productAddViewModel = ProductAddViewModel()
        self.productAddViewModel?.initModel()
        
        self.setupDismissGestureRecognizer()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("unwinding")
    }
}

//MARK: TextField delegate functions
extension ProductAddViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 200)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 200)
    }
}

//MARK: TextView delegate functions
extension ProductAddViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        animateViewMoving(up: true, moveValue: 200)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, moveValue: 200)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        if (self.isViewMovedUp && up) {
            return
        }
        // check the orientation of controller to cut movement if it is in landscape
        let move = (self.statusBarOrientation?.isPortrait ?? false ? moveValue : moveValue/2)
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -move : move)
        
        UIView.animate(withDuration: movementDuration) {
            self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        }
        self.isViewMovedUp = up
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        guard let text = textView.text else {return}
        self.productAddViewModel?.productDescription = text
    }
}

//MARK: common functions
extension ProductAddViewController {
    
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
