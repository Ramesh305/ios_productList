//
//  CartVM.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//

import Foundation

class CartVM{
    
    var items:[Items] = []
    init() {
        self.items = []
    }
        func fetchData(compilationHandler:@escaping(Bool)->Void){
            items.removeAll()
            if let  item =  APIResponse.shared.allDataFetch(){
                items = item
                compilationHandler(true)
            }else{
                compilationHandler(false)
            }
            
        }
}


