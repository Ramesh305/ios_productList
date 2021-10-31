//
//  ConfirmOrder.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//

import UIKit
class ConfirmOrder: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var congratulationlabel: UILabel!
    @IBOutlet weak var yourorder: UILabel!
    @IBOutlet weak var confirmView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         setUI()
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        // Call stopAnimating() when need to stop activity indicator
        //myActivityIndicator.stopAnimating()
        
        
        view.addSubview(myActivityIndicator)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            myActivityIndicator.stopAnimating()
            myActivityIndicator.isHidden = true
            self.showUI()
        }
        
        
        
    }
    
    @IBAction func confirmOrderBtn(_ sender: Any) {
        if let items = APIResponse.shared.allDataFetch(){
            for item in items{
                PersistanceStore.shared.context.delete(item)
                PersistanceStore.shared.saveContext()
            }
        }
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: self)
        self.view.window?.rootViewController?.dismiss(animated: true, completion:nil)
        
    }
    
}


extension ConfirmOrder{
    func setUI(){
        DispatchQueue.main.async {
            self.confirmView.layer.cornerRadius = 20
            self.congratulationlabel.isHidden = true
            self.yourorder.isHidden = true
            self.confirmView.isHidden = true
            self.iconImage.isHidden = true
            
        }
    }
    
    
    func showUI(){
        DispatchQueue.main.async {
            self.confirmView.layer.cornerRadius = 20
            self.congratulationlabel.isHidden = false
            self.yourorder.isHidden = false
            self.confirmView.isHidden = false
            self.iconImage.isHidden = false
            
            
        }
    }
    
}
