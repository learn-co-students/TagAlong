//
//  ShakeInstructionViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/22/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class ShakeInstructionViewController: UIViewController {
 
    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
    let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
    let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
    let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
    let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)
    
    let randomCuisineLabel = UILabel()
    let shakePhoneLabel = UILabel()
    let shakeIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraLightGreen
        formatLabelAndButtons()
    }
    
    func formatLabelAndButtons() {
        randomCuisineLabel.frame = view.bounds.insetBy(dx: 20, dy: 20)
        randomCuisineLabel.lineBreakMode = .byWordWrapping
        randomCuisineLabel.numberOfLines = 0
        
        randomCuisineLabel.text = "Want to choose a random cuisine?"
        randomCuisineLabel.font = UIFont(name: "AvenirNext-Bold", size: 22.0)
        view.addSubview(randomCuisineLabel)
        randomCuisineLabel.textColor = phaedraDarkGreen
        randomCuisineLabel.textAlignment = .center
        randomCuisineLabel.translatesAutoresizingMaskIntoConstraints = false
        randomCuisineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        randomCuisineLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        
        
        
        view.addSubview(shakePhoneLabel)
        view.addSubview(shakeIcon)
        
        
        
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
