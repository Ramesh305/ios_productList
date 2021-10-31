//
//  APIResponse.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 17/10/21.
//

import Foundation
import UIKit
import CoreData
class APIResponse{
    private init(){
        
    }
    static let shared = APIResponse()
    //MARK:Get data from server.
    func getRespnse(compilation:@escaping(ResponseData)-> Void){
        
        let url = URL(string: "https://my-json-server.typicode.com/nancymadan/assignment/db")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                //print(data)
                compilation(ResponseData(data: data, error:nil))
            }
        }.resume()
        
        
    }
    
    func fetchData(databyidentifier:Products)-> Items?{
        let fetchRequest = NSFetchRequest<Items>(entityName: "Items")
        fetchRequest.predicate = NSPredicate(format: "productName = %@", databyidentifier.name as! CVarArg)
        do{
            let fetch = try PersistanceStore.shared.context.fetch(fetchRequest) as?[Items]
            print(fetch?.first?.productName)
            return fetch?.first
        }catch{
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
    
    
    func deleteDataByIdentifier(data:Products){
        
        let fetch = fetchData(databyidentifier: data)
        guard let carts = fetch?.carts,carts.count>0 else {
            return
        }
        PersistanceStore.shared.context.delete(carts.first!)
        PersistanceStore.shared.saveContext()
    }
    
    func allDataFetch()->[Items]?{
        let fetchRequest = NSFetchRequest<Items>(entityName: "Items")
        do{
            let fetch = try PersistanceStore.shared.context.fetch(fetchRequest) as?[Items]
            //print(fetch?.first?.productName)
            return fetch
        }catch{
            print(error.localizedDescription)
            return nil
        }
        return nil
        
    }
    
}
