//
//  Helper.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 18/10/21.
//

import Foundation
import UIKit
import Kingfisher
class Helper{
    private init(){
        
    }
    class func setImage(imageView:UIImageView,url:String,defaultImage:UIImage) {
        imageView.image = nil
        imageView.kf.indicatorType = .activity
        
        if  let trimmedString = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        {
            let trimmedStrings = trimmedString.replacingOccurrences(of: "http://s3.amazonaws.com", with: "https://s3.amazonaws.com").removingPercentEncoding
            imageView.kf.setImage(with: URL(string: trimmedStrings!), placeholder: defaultImage)
        }
    }
    
}
