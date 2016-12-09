//
//  TabBarController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/27/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var tagAlong  = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraYellow
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstTab = RestaurantChatViewController()
        let tabBarItem1 = UITabBarItem(title: "Restaurant Info", image: UIImage(named: "fork-knife.png"), selectedImage: UIImage(named: "fork-knife.png"))
        firstTab.tabBarItem = tabBarItem1
        
        let secondTab = PreferenceViewController()
        let tabBarItem2 = UITabBarItem(title: "Preferences", image: UIImage(named: "gear.png"), selectedImage: UIImage(named: "gear.png"))
        secondTab.tabBarItem = tabBarItem2
        
        self.viewControllers = [firstTab, secondTab]
        
    }
    
    /// UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("something is happening")
        print("selected \(viewController.title)")
    }
    

 

}
