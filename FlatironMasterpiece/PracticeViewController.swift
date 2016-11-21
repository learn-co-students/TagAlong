//
//  PracticeViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {
    
    let store = UsersDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        print("is running")
        view.backgroundColor = UIColor.purple
        createSegmentedController()
    }
    
    func createSegmentedController() {
        let budgetArray:[String] = ["💰", "💰💰", "💰💰💰", "💰💰💰💰"]
        let budgetSC = UISegmentedControl(items: budgetArray)
        budgetSC.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        budgetSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 50, width: frame.width - 20, height: frame.height * 0.08)
        
        budgetSC.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir Next", size: 16.0)! ], for: .normal)
        budgetSC.layer.cornerRadius = 5
        budgetSC.backgroundColor = UIColor.white
        budgetSC.tintColor = UIColor.green
        budgetSC.addTarget(self, action: #selector(printChosenBudget(sender:)), for: .valueChanged)
        self.view.addSubview(budgetSC)
        
    }
    
    func printChosenBudget(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("user chose 💰")
        case 1:
            print("user chose 💰💰")
        case 2:
            print("user chose 💰💰💰")
        case 3:
            print("user chose 💰💰💰💰")
        default:
            print("error with user chosing budget")
        }
    }
    
}


















