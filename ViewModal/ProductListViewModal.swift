//
//  ProductListViewModal.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 17/10/21.
//

import Foundation
import UIKit
import CoreData
class  ProductListViewModal{
    var arrayofProduct = [[Products?]]()
     func getDataFromServer(compilation:@escaping(Bool)->Void){
        APIResponse.shared.getRespnse(){ [self] succss in
            if succss.error == nil{
                let decoder = JSONDecoder()
                   self.arrayofProduct.removeAll()
                    do {
                        let response = try! JSONDecoder().decode(ProductItem.self, from: succss.data!)
                        print(response.products?.count)
                        var array = response.products?.filter({ (name) -> Bool in
                            let value = Double(name.price!)
                            return  value!>1000
                        })
                        var array1 = response.products?.filter({ (name) -> Bool in
                            let value = Double(name.price!)
                            return  value! <= 1000
                        })
                        arrayofProduct.append(array!)
                        arrayofProduct.append(array1!)
                        compilation(true)
                    } catch {
                        compilation(false)
                        print(error.localizedDescription)
                    }
            }else{
                print(succss.data)
                compilation(false)
            }
        }
    }
    
    func deleteItem(data:Products,compilationHander:@escaping(Bool)->Void){
        
        APIResponse.shared.deleteDataByIdentifier(data: data)
        compilationHander(true)
        
    }
    
    
    
    func saveData(data:Products?){
        if let data = data{
            let fetch =  APIResponse.shared.fetchData(databyidentifier: data)
            if fetch != nil{
                let cart = Cart(context: PersistanceStore.shared.context)
                cart.image_url = data.image_url
                cart.name = data.name
                cart.rating = "\(data.rating)"
                cart.price = data.price
                cart.uuid = data.uiid
                cart.items = fetch
                fetch!.addToCarts(cart)
                PersistanceStore.shared.saveContext()
                
            }else{
                let productName = Items(context: PersistanceStore.shared.context)
                productName.productName = data.name
                let cart = Cart(context: PersistanceStore.shared.context)
                cart.image_url = data.image_url
                cart.name = data.name
                cart.rating = "\(data.rating)"
                cart.price = data.price
                cart.uuid = data.uiid
                cart.items = productName
                productName.addToCarts(cart)
                PersistanceStore.shared.saveContext()
            }
        }
    }
    
    func fetchData(data:Products){
       let fetch =  APIResponse.shared.fetchData(databyidentifier: data)
    }
    
    
}

