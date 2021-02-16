//
//  ProductTableviewCell.swift
//  FinchTest
//
//  Created by VNS Work on 10.02.2021.
//

import UIKit

class ProductTableviewCell: UITableViewCell {
    
    var isShadowConfigured: Bool = false

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.configureShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 3, bottom: 3, right: 3))
//    }
}

extension ProductTableviewCell {
    
    func configureShadow() {
//        if self.isShadowConfigured {return}
//        // add shadow on cell
//        self.backgroundColor = .clear // very important
//        self.layer.masksToBounds = false
//        self.layer.shadowOpacity = 0.23
//        self.layer.shadowRadius = 4
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowColor = UIColor.black.cgColor
//
//        // add corner radius on `contentView`
//        if #available(iOS 13.0, *) {
//            self.contentView.backgroundColor = .systemBackground
//        } else {
//            self.contentView.backgroundColor = .white
//        }
//        self.contentView.layer.cornerRadius = 8
//        self.isShadowConfigured = true
    }
}
