//
//  OnboardingViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/12/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var welcomeLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.10)
        setupViews()
        

        // Do any additional setup after loading the view.
    }

    func setupViews() {
        view.addSubview(welcomeLabel)
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        welcomeLabel.textColor = phaedraOrange
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        welcomeLabel.specialConstrain(to: view)
    }


}
