//
//  Commonfile.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 17/10/21.
//

import Foundation
import UIKit
struct ResponseData{
    let data:Data?
    let error:Error?
}
protocol CellforConfiguration {
    func cellConfiguration(_ cell:UITableViewCell)
    func cellconfigurationPluse(_ cell:UITableViewCell)
    func cellconfigurationminus(_ cell:UITableViewCell)
}



extension CellforConfiguration{
    func cellConfiguration(_ cell:UITableViewCell){
    }
    func cellconfigurationminus(_ cell:UITableViewCell){

    }
    func cellconfigurationPluse(_ cell:UITableViewCell){
        
    }
    
}
