//
//  WaitingForHostViewController.swift
//  
//
//  Created by Erica Millado on 12/7/16.
//
//

import UIKit

class WaitingForHostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func observeHostTagalong() {
        
        FirebaseManager.shared.observeTagalongRequests { (snapshot) in
            
            
            
            
            
        }
        
        
        
        
    }

}
