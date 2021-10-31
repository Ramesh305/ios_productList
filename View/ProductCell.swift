//
//  ProductCell.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 17/10/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var quantitylbl: UILabel!
    @IBOutlet weak var plusebtn: UIButton!
    
    @IBOutlet weak var minusbtn: UIButton!
    @IBOutlet weak var addtocartBtn: UIButton!
    @IBOutlet weak var addtoCartView: UIView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var cellConfigurationDelegate:CellforConfiguration?
    var data:Products?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addtoCartView.isHidden = true
    }
    //MARK:set Value for UI
    func setData(data:Products){
        print("ramesh==",data.uiid)
        productPrice.text = data.price
        productName.text = data.name
        Helper.setImage(imageView:productImage,url:data.image_url!,defaultImage:UIImage())
        if data.value && data.quantityCount>0{
            addtocartBtn.isHidden = true
            addtoCartView.isHidden = false
            quantitylbl.text = "\(data.quantityCount)"
            
        }else{
            addtocartBtn.isHidden = false
            addtoCartView.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addtocartBtnAction(_ sender: Any) {
        
        cellConfigurationDelegate?.cellConfiguration(self)
        
    }
    
    
    @IBAction func plusebtnAction(_ sender: Any) {
        cellConfigurationDelegate?.cellconfigurationPluse(self)
    }
    
    @IBAction func minusbtnAction(_ sender: Any) {
        cellConfigurationDelegate?.cellconfigurationminus(self)
    }
    
}




extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}
