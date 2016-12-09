//
//  HostOrTagAlongViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/26/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class HostOrTagAlongViewController: UIViewController {
    
    let searchLabel:UILabel = UILabel()
    let searchButton: UIButton = UIButton()
    let tagAlongLabel: UILabel = UILabel()
    let tagAlongButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))
    let preferencesButton: UIButton = UIButton(type: UIButtonType.custom) as UIButton
    let preferencesLabel = UILabel()
    let preferencesImage = UIImage(named: "gear_redLarge.png")! as UIImage

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraOliveGreen
        setupViews()
        self.title = "Search or Tag Along"
     }
    
    override func viewWillAppear(_ animated: Bool) {
//        view.addSubview(searchLabel)
//        searchLabel.center.x -= view.bounds.width
//        searchButton.center.x -= view.bounds.width
//        tagAlongLabel.center.x -= view.bounds.width
//        tagAlongButton.center.x -= view.bounds.width
//        UIView.animate(withDuration: 0.5) {
//            self.searchLabel.center.x += self.view.bounds.width
//        }
        
    }

    func setupViews() {
        view.addSubview(searchLabel)
        searchLabel.font = UIFont(name: "OpenSans-Bold", size: 30.0)
        searchLabel.lineBreakMode = .byWordWrapping
        searchLabel.numberOfLines = 0
        searchLabel.text = "Host a Tag Along"
        searchLabel.textColor = phaedraYellow
        searchLabel.textAlignment = .center
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        searchLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        searchLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        view.addSubview(searchButton)
        searchButton.backgroundColor = phaedraOrange
        searchButton.layer.cornerRadius = 5
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        searchButton.titleLabel?.textAlignment = .center
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        searchButton.addTarget(self, action: #selector(searchForRestaurant), for: .touchUpInside)
        searchButton.setTitleColor(phaedraYellow, for: .normal)
        searchButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        view.addSubview(tagAlongLabel)
        tagAlongLabel.font = UIFont(name: "OpenSans-Bold", size: 30.0)
        tagAlongLabel.lineBreakMode = .byWordWrapping
        tagAlongLabel.numberOfLines = 0
        tagAlongLabel.text = "Join a Tag Along"
        tagAlongLabel.textColor = phaedraYellow
        tagAlongLabel.textAlignment = .center
        tagAlongLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 150).isActive = true
        tagAlongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        view.addSubview(tagAlongButton)
        tagAlongButton.backgroundColor = phaedraLightGreen
        tagAlongButton.layer.cornerRadius = 5
        tagAlongButton.setTitle("Search", for: .normal)
        tagAlongButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        tagAlongButton.titleLabel?.textAlignment = .center
        tagAlongButton.translatesAutoresizingMaskIntoConstraints = false
        tagAlongButton.topAnchor.constraint(equalTo: tagAlongLabel.bottomAnchor, constant: 20).isActive = true
        tagAlongButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagAlongButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        tagAlongButton.addTarget(self, action: #selector(joinATagAlong), for: .touchUpInside)
        tagAlongButton.setTitleColor(phaedraOrange, for: .normal)
        tagAlongButton.setTitleColor(phaedraDarkGreen, for: .highlighted)
        
        view.addSubview(preferencesLabel)
        preferencesLabel.font = UIFont(name: "OpenSans-Bold", size: 12.0)
        preferencesLabel.lineBreakMode = .byWordWrapping
        preferencesLabel.numberOfLines = 0
        preferencesLabel.text = "Preferences"
        preferencesLabel.textColor = phaedraYellow
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.topAnchor.constraint(equalTo: tagAlongButton.bottomAnchor, constant: 40).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        preferencesButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        preferencesButton.setImage(preferencesImage, for: .normal)
        view.addSubview(preferencesButton)
        preferencesButton.backgroundColor = phaedraOliveGreen
        preferencesButton.layer.cornerRadius = 5
        preferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        preferencesButton.titleLabel?.textAlignment = .center
        preferencesButton.translatesAutoresizingMaskIntoConstraints = false
        preferencesButton.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 10).isActive = true
        preferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        preferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        preferencesButton.addTarget(self, action: #selector(goToPreferences), for: .touchUpInside)
        preferencesButton.imageView?.contentMode = .scaleAspectFit
        preferencesButton.setTitleColor(phaedraOrange, for: .normal)
        preferencesButton.setTitleColor(phaedraDarkGreen, for: .highlighted)

    }
    
    func searchForRestaurant() {
        
        print("User wants to search for a restaurant.")
        
        let shakeInstVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstVC, animated: true)
    }
    
    func joinATagAlong() {
        print("User wants to tag along with another user.")
       
        let tagAlongVC = TagAlongViewController()
        self.navigationController?.pushViewController(tagAlongVC, animated: true)
        
    }
    
    func goToPreferences() {
        print("User wants to go to preferences")
        let preferencesVC = PreferenceViewController()
        self.navigationController?.pushViewController(preferencesVC, animated: true)
    }


}
