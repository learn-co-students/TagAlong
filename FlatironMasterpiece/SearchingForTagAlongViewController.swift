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
    var searchAgainButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    var beTagAlongGuestButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
       
    }
    
    override func loadView() {
        super.loadView()
        setupLabel()
        setupSpinner()
        setupButtons()
        
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
    
    func setupButtons() {
        view.addSubview(searchAgainButton)
        searchAgainButton.backgroundColor = phaedraLightGreen
        searchAgainButton.layer.cornerRadius = 5
        searchAgainButton.layer.borderWidth = 1
        searchAgainButton.layer.borderColor = phaedraDarkGreen.cgColor
        searchAgainButton.setTitle("Choose Another Restaurant", for: UIControlState.normal)
        searchAgainButton.setTitle("Tutorial Played", for: .highlighted)
        searchAgainButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        searchAgainButton.titleLabel?.textAlignment = .center
        searchAgainButton.translatesAutoresizingMaskIntoConstraints = false
        searchAgainButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 340).isActive = true
        searchAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchAgainButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        searchAgainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        searchAgainButton.addTarget(self, action: #selector(returnToDeckView), for: .touchUpInside)
        searchAgainButton.setTitleColor(phaedraDarkGreen, for: .normal)
        searchAgainButton.setTitleColor(phaedraYellow, for: .highlighted)
        
        view.addSubview(beTagAlongGuestButton)
        beTagAlongGuestButton.backgroundColor = phaedraLightGreen
        beTagAlongGuestButton.layer.cornerRadius = 5
        beTagAlongGuestButton.layer.borderWidth = 1
        beTagAlongGuestButton.layer.borderColor = phaedraDarkGreen.cgColor
        beTagAlongGuestButton.setTitle("Be a Tag Along Guest Instead", for: UIControlState.normal)
        beTagAlongGuestButton.setTitle("Tutorial Played", for: .highlighted)
        beTagAlongGuestButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        beTagAlongGuestButton.titleLabel?.textAlignment = .center
        beTagAlongGuestButton.translatesAutoresizingMaskIntoConstraints = false
        beTagAlongGuestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 390).isActive = true
        beTagAlongGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        beTagAlongGuestButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        beTagAlongGuestButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        beTagAlongGuestButton.addTarget(self, action: #selector(seeOtherTagAlongs), for: .touchUpInside)
        beTagAlongGuestButton.setTitleColor(phaedraDarkGreen, for: .normal)
        beTagAlongGuestButton.setTitleColor(phaedraYellow, for: .highlighted)

    }
    
    func returnToDeckView() {
        print("User wants to return to deck view")
        let shakeInstructionVC = ShakeInstructionViewController()
//        self.navigationController?.present(shakeInstructionVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(shakeInstructionVC, animated: true)
//        let shakeInstructionVC = ShakeInstructionViewController()
//        self.navigationController?.pushViewController(shakeInstructionVC, animated: true)
    }

    func seeOtherTagAlongs() {
        print("User wants to see other tagalongs")
        let tagAlongsVC = TagAlongViewController()
        self.navigationController?.pushViewController(tagAlongsVC, animated: true)
    }
    
    

}

























