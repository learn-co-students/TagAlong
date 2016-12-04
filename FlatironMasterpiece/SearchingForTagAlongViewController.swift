//
//  SearchingForTagAlongViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/3/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SearchingForTagAlongViewController: UIViewController {
    
    let searchingLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        setupLabel()
        setupSpinner()
    }

    func setupLabel() {
        view.addSubview(searchingLabel)
        searchingLabel.text = "Searching for your Tag Along..."
        searchingLabel.font = UIFont(name: "OpenSans-Bold", size: 16.0)
        searchingLabel.textColor = phaedraOrange
        searchingLabel.textAlignment = .center
        searchingLabel.translatesAutoresizingMaskIntoConstraints = false
        searchingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        searchingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupSpinner() {
        var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.color = phaedraDarkGreen
        activityIndicator.layer.cornerRadius = 4
        activityIndicator.layer.backgroundColor = phaedraLightGreen.cgColor
        activityIndicator.layer.borderWidth = 1
        activityIndicator.layer.borderColor = phaedraDarkGreen.cgColor
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    

}

























