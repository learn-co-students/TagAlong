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
        searchingLabel.specialConstrain(to: view)
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
