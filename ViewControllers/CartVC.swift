//
//  CartVC.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//

import UIKit
import ListPlaceholder
class CartVC: UIViewController {
    
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var cartTableview: UITableView!
    var cartVM = CartVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableview.delegate = self
        cartTableview.dataSource = self
        cartTableview.reloadData()
        self.cartTableview.showLoader()
        checkoutView.layer.cornerRadius = 20
        checkoutView.clipsToBounds = true
        cartVM.fetchData(){ [weak self](succss) in
            print(succss)
            print(self!.cartVM.items.count)
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self?.cartTableview.reloadData()
                    self?.cartTableview.hideLoader()
                })
            }
            
        }
    }
    
    
    @IBAction func checkoutBtn(_ sender: Any) {
        
        
        
        
        
        
    }
    
}



extension CartVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cartVM.items.count>0{
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartVM.items.count>0{
            return cartVM.items.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableview.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell
        if cartVM.items.count>0{
            cell?.setdata(data: cartVM.items[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
