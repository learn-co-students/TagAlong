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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
    
    override func loadView() {
        super.loadView()
        restaurantView = RestaurantView()
        self.view = restaurantView
    }
    
    public func showTagAlongAlert() {
        let confirmTagAlongAlert = UIAlertController(title: "Confirm", message: "Click \"OK\" to confirm that you want to host a Tag Along", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("User clicked cancel")
        })
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            //TODO:
            //call on function that creates a tagalong from Firebase Manager
            //segue way searchingForTagAlong vc


            let searchingVC = SearchingForTagAlongViewController()
//            self.navigationController?.pushViewController(searchingVC, animated: true)
            let nav = UINavigationController(rootViewController: searchingVC)

        })
        confirmTagAlongAlert.addAction(cancelAction)
        confirmTagAlongAlert.addAction(confirmAction)
        self.present(confirmTagAlongAlert, animated: true, completion: nil)

    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
