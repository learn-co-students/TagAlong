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
        //assign self for delegate so we can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //create tab 1 - chat
        //TODO: - replace this tab 1 with chat
        let chatVC = ChatViewController()
        let tabOne = chatVC
        chatVC.tagalongTag = tagAlong
        let tabOneBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "ic_speaker_notes.png"), selectedImage: UIImage(named: "ic_speaker_notes.png"))
        tabOne.tabBarItem = tabOneBarItem

        //create tab 2 - restaurant detail view
        let tabTwo = SelectedRestaurantViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Restaurant Info", image: UIImage(named: "fork-knife.png"), selectedImage: UIImage(named: "fork-knife.png"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        //create tab 3 - preferences
        let tabThree = PreferenceViewController()
        let tabeThreeBarItem3 = UITabBarItem(title: "Preferences", image: UIImage(named: "gear.png"), selectedImage: UIImage(named: "gear.png"))
        tabThree.tabBarItem = tabeThreeBarItem3
        
        self.viewControllers = [tabTwo, tabOne, tabThree]
        
    }
    
    /// UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("something is happening")
        print("selected \(viewController.title)")
    }
    

 

}
