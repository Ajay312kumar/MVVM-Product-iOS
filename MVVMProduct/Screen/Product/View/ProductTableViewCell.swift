//
//  ProductTableViewCell.swift
//  MVVMProduct
//
//  Created by ajay kumar on 12/04/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategories: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    var product: ProductModel?{
        didSet{
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func productDetailConfiguration(){
        guard let product else { return }
        productTitleLabel.text = product.title
        productCategories.text = product.category
        descriptionLabel.text = product.description
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        priceLabel.text = "$\(product.price)"
        productImageView.setImage(with: product.image)
    }
    
}
