//
//  CartCell.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//

import UIKit

class CartCell: UITableViewCell {
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
 
    @IBOutlet weak var productImage: UIImageView!
    var item:Items?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setdata(data:Items?){
        if let data1 = data{
            productName.text = data1.productName
            productPrice.text = data1.carts?.first?.price
            if data1.carts!.count>0 as Int{
                Helper.setImage(imageView:productImage, url: (data?.carts?.first?.image_url)!, defaultImage:UIImage())
        
        }
        
    }
    
    
    
    }

}
