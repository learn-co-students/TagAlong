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
        
        let firstTab = SelectedRestaurantViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Restaurant Info", image: UIImage(named: "fork-knife.png"), selectedImage: UIImage(named: "fork-knife.png"))
        firstTab.tabBarItem = tabTwoBarItem2
        
        let chatVC = ChatViewController()
        let secondTab = chatVC
        chatVC.tagalongTag = tagAlong
        let tabOneBarItem1 = UITabBarItem(title: "Chat", image: UIImage(named: "ic_speaker_notes.png"), selectedImage: UIImage(named: "ic_speaker_notes.png"))
        secondTab.tabBarItem = tabOneBarItem1
        
        let thirdTab = PreferenceViewController()
        let tabeThreeBarItem3 = UITabBarItem(title: "Preferences", image: UIImage(named: "gear.png"), selectedImage: UIImage(named: "gear.png"))
        thirdTab.tabBarItem = tabeThreeBarItem3
        
        self.viewControllers = [firstTab, secondTab, thirdTab]
        
    }
    
    /// UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("something is happening")
        print("selected \(viewController.title)")
    }
    

 

}
