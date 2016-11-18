//
//  PreferencesViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    var preferencesLabel = UILabel()
    var dineWithCompanySwitch = UISwitch()
    var dineWithCompanyLabel = UILabel()
    var replayTutorialButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
    
    func findDiningPartner(sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        formatSwitch()
        formatLabels()
        formatButtons()
     }
    
    // TODO: - write function that displays replayTutorial
    func replayTutorial() {
        print("Replay tutorial requested.")
    }
    
    func formatButtons() {

        view.addSubview(replayTutorialButton)
        // TODO: - change button color
        replayTutorialButton.backgroundColor = UIColor.orange
        replayTutorialButton.layer.cornerRadius = 5
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.textColor = UIColor.blue
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(replayTutorial), for: .touchUpInside)
        replayTutorialButton.setTitleColor(UIColor.green, for: .highlighted)

    }
    
    func formatLabels() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        // TODO: - decide on preferences label font and font size
//        preferencesLabel.font = UIFont(name: String, size: <#T##CGFloat#>)
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
        
        view.addSubview(dineWithCompanyLabel)
        dineWithCompanyLabel.text = "Dine with company?"
        // TODO: - decide on dineWithCompany label font and font size
        dineWithCompanyLabel.textAlignment = .center
        dineWithCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        dineWithCompanyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func formatSwitch() {
        view.addSubview(dineWithCompanySwitch)
        dineWithCompanySwitch.center = view.center
        dineWithCompanySwitch.setOn(false, animated: false)
        dineWithCompanySwitch.tintColor = UIColor.green
        dineWithCompanySwitch.onTintColor = UIColor.green
        dineWithCompanySwitch.thumbTintColor = UIColor.lightGray
        dineWithCompanySwitch.addTarget(self, action: #selector(findDiningPartner), for: UIControlEvents.valueChanged)
        dineWithCompanySwitch.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanySwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        dineWithCompanySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 85).isActive = true
        dineWithCompanySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    //american, asian, italian, healthy, latin, unhealthy

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


