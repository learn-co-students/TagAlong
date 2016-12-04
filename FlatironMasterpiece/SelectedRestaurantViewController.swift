//
//  SelectedRestaurantViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SelectedRestaurantViewController: UIViewController {
    
    var restaurantView: RestaurantView!
    var tagAlongTapped:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantView.delegate = self
        view.backgroundColor = UIColor.blue
    }
    
    override func loadView() {
        super.loadView()
        restaurantView = RestaurantView()
        self.view = restaurantView
        if !tagAlongTapped {
            canDisplayImage()
        }
    }

}

extension SelectedRestaurantViewController: RestaurantViewDelegate {
    
    func canDisplayImage() {
        
        let confirmTagAlongAlert = UIAlertController(title: "Confirm", message: "Click \"OK\" to confirm that you want to host a Tag Along", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("User clicked cancel")
        })
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            //TODO:
            //call on function that creates a tagalong from Firebase Manager
            //segue way searchingForTagAlong vc
            
            
            let searchingVC = SearchingForTagAlongViewController()
//            let nav = UINavigationController(rootViewController: searchingVC)
            self.navigationController?.present(searchingVC, animated: true, completion: nil)
            
        })
        confirmTagAlongAlert.addAction(cancelAction)
        confirmTagAlongAlert.addAction(confirmAction)
        self.present(confirmTagAlongAlert, animated: true, completion: nil)
        
    }
    
}
