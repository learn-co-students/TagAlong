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
        self.title = "Restaurant Detail View"
        view.backgroundColor = UIColor.blue
    }
    
    override func loadView() {
        super.loadView()
        restaurantView = RestaurantView()
        self.view = restaurantView
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
