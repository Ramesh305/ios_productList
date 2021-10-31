//
//  ViewController.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 17/10/21.
//
let myNotificationKey = "com.bobthedeveloper.notificationKey"
import UIKit
import ListPlaceholder
class ProductListVC: UIViewController{
    @IBOutlet weak var tableview: UITableView!
    var productListVM = ProductListViewModal()
    var counterItem:Int = 0
    @IBOutlet weak var numberCountlbl: UILabel!
    @IBOutlet weak var buttoncart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        self.tableview.showLoader()
        DispatchQueue.main.async {
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
        }
        productListVM.getDataFromServer(){ succuss in
            if succuss{
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.tableview.hideLoader()
                }
            }
        }

        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(doThisWhenNotify),
                                                   name: NSNotification.Name(rawValue: myNotificationKey),
                                                   object: nil)
    }
    
    @objc func doThisWhenNotify() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        self.tableview.showLoader()
        DispatchQueue.main.async {
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
        }
        productListVM.getDataFromServer(){ succuss in
            if succuss{
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    self.tableview.hideLoader()
                    self.numberCountlbl.text = "0"
                    self.counterItem = 0
                }
            }
        }
    }
}

extension ProductListVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if (productListVM.arrayofProduct.count != 0){
            return productListVM.arrayofProduct.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productListVM.arrayofProduct.count>0{
            
            return productListVM.arrayofProduct[section].count
        }else{
            return 10
        }
        return productListVM.arrayofProduct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as? ProductCell
         cell!.cellConfigurationDelegate = self
        if (productListVM.arrayofProduct.count != 0){
            if indexPath.section == 0{
                let array = productListVM.arrayofProduct[indexPath.section]
                cell?.setData(data:array[indexPath.row]!)
            }else{
                let array = productListVM.arrayofProduct[indexPath.section]
                cell?.setData(data:array[indexPath.row]!)
            }
            return cell!
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

//MARK add animation for cart.

extension ProductListVC: CellforConfiguration{
    func cellConfiguration(_ cell:UITableViewCell){
        print("selected index=== \(10)")
        if let indexPath = tableview.indexPath(for: cell){
            print(indexPath.section)
            let array = productListVM.arrayofProduct[indexPath.section]
            if let itemA = array[indexPath.row] as? Products{
                itemA.value = true
                itemA.quantityCount  = itemA.quantityCount + 1
                self.counterItem = self.counterItem + 1
                productListVM.saveData(data: itemA)
                PersistanceStore.shared.saveContext()
                let cell = self.tableview.cellForRow(at: indexPath) as! ProductCell
                
                let imageViewPosition : CGPoint = cell.productImage.convert(cell.productImage.bounds.origin, to: self.view)
                
                let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.productImage.frame.size.width, height: cell.productImage.frame.size.height))
                
                imgViewTemp.image = cell.productImage.image
                animation(tempView: imgViewTemp)
                
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    func cellconfigurationminus(_ cell:UITableViewCell){
        if let indexPath = tableview.indexPath(for: cell){
            print("minus button")
            let array = productListVM.arrayofProduct[indexPath.section]
            if let itemA = array[indexPath.row] as? Products{
                if itemA.quantityCount>0{
                    itemA.quantityCount = itemA.quantityCount - 1
                    self.counterItem = self.counterItem - 1
                    DispatchQueue.main.async {
                     self.numberCountlbl.text = "\(self.counterItem)"
                    }
                    productListVM.deleteItem(data: itemA) { (sucss) in
                        self.tableview.reloadData()
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    func cellconfigurationPluse(_ cell:UITableViewCell){
        if let indexPath = tableview.indexPath(for: cell){
            let array = productListVM.arrayofProduct[indexPath.section]
            if let itemA = array[indexPath.row] as? Products{
                if itemA.quantityCount>=0{
                    itemA.quantityCount = itemA.quantityCount + 1
                    productListVM.saveData(data: itemA)
                    self.counterItem = self.counterItem + 1
                    let cell = self.tableview.cellForRow(at: indexPath) as! ProductCell
                    
                    let imageViewPosition : CGPoint = cell.productImage.convert(cell.productImage.bounds.origin, to: self.view)
                    
                    let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.productImage.frame.size.width, height: cell.productImage.frame.size.height))
                    
                    imgViewTemp.image = cell.productImage.image
                    animation(tempView: imgViewTemp)
                    
                    
                }
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
}



extension ProductListVC{
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = self.buttoncart.frame.origin.x
                tempView.frame.origin.y = self.buttoncart.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    //self.counterItem += 1
                    self.numberCountlbl.text = "\(self.counterItem)"
                    self.buttoncart.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.buttoncart.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
}
