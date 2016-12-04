//
//  RestaurantView.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

protocol RestaurantViewDelegate {
    func canDisplayImage(sender:UIImage) -> Bool
}

class RestaurantView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var selectedCuisineLabel: UILabel!
    @IBOutlet weak var selectedRestaurantLabel: UILabel!
    @IBOutlet weak var selectedRestaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantPricingLabel: UILabel!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        //TODO: - add code that will take the user back to deck view
    }
    
    @IBAction func hostTagAlongTapped(_ sender: UIButton) {
        //TODO: - add code that will create alert controller
//        SelectedRestaurantViewController.showTagAlongAlert(self)
        
//        let confirmTagAlongAlert = UIAlertController(title: "Confirm", message: "Click \"OK\" to confirm that you want to host a Tag Along", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
//            print("User clicked cancel")
//        })
//        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
//            //TODO: 
//            //call on function that creates a tagalong from Firebase Manager
//            //segue way searchingForTagAlong vc
//
//            
//            let searchingVC = SearchingForTagAlongViewController()
////            self.navigationController?.pushViewController(searchingVC, animated: true)
//            let nav = UINavigationController(rootViewController: searchingVC)
//            
//        })
//        confirmTagAlongAlert.addAction(cancelAction)
//        confirmTagAlongAlert.addAction(confirmAction)

    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SelectedRestaurant", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
 
    

}
