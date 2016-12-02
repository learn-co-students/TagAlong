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

    override func viewDidLoad() {
        super.viewDidLoad()
        //assign self for delegate so we can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //create tab 1 - chat
        //TODO: - replace this tab 1 with chat
        let tabOne = ChatViewController()
        let tabOneBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "ic_speaker_notes.png"), selectedImage: UIImage(named: "ic_speaker_notes.png"))
        tabOne.tabBarItem = tabOneBarItem
        let allChatsRef = FIRDatabase.database().reference().child("chats")
        // chatRef should point to only one single chat --- eventually Auto ID
        tabOne.chatRef = allChatsRef.child("christinaChat")
        
        //create tab 2 - restaurant detail view
        let tabTwo = SelectedRestaurantViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Restaurant Info", image: UIImage(named: "fork-knife.png"), selectedImage: UIImage(named: "fork-knife.png"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        //create tab 3 - preferences
        let tabThree = PreferenceViewController()
        let tabeThreeBarItem3 = UITabBarItem(title: "Preferences", image: UIImage(named: "gear.png"), selectedImage: UIImage(named: "gear.png"))
        tabThree.tabBarItem = tabeThreeBarItem3
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
        
    }
    
    /// UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is ChatViewController {
            let vc = viewController as! ChatViewController
            let allChatsRef = FIRDatabase.database().reference().child("chats")
            // chatRef should point to only one single chat --- eventually Auto ID
            vc.chatRef = allChatsRef.child("christinaChat")
            present(vc, animated: true, completion: nil)
        }
        
        
        print("selected \(viewController.title!)")
    }
    

 

}
