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
            if #available(iOS 13.0, *) {
                guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {return nil}
                return orientation
            } else {
                return UIInterfaceOrientation(rawValue: 0)
            }
        }
    }
    
    var productAddViewModel: ProductAddViewModel? = nil
    var completion: (([String]) -> Void)? = nil
    
    var isViewMovedUp: Bool = false

    @IBOutlet weak var productImage: UIImageView! {
        didSet {
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(generateImage))
            doubleTap.numberOfTapsRequired = 2
            productImage.addGestureRecognizer(doubleTap)
        }
    }
    
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
            guard let newProduct = self.productAddViewModel?.getNewProduct() else { return}
            completion?(newProduct)
            self.navigationController?.popViewController(animated: true)
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
        let alert = UIAlertController(title: "Внимание", message: "Пожалуйста, заполните все поля и coздайте фото продукта двойным тапом по дефолтной картинке", preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setupDismissGestureRecognizer () -> Void {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func generateImage() {
        
        self.productAddViewModel?.productImage = ImageService.generateTempImage(width: 512, height: 512, completion: {[weak self] image in self?.productImage.image = image})
        
    }
}
