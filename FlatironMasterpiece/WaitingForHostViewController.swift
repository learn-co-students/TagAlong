//
//  WaitingForHostViewController.swift
//
//
//  Created by Erica Millado on 12/7/16.
//
//
import UIKit

class WaitingForHostViewController: UIViewController {
    
    let store = FirebaseManager.shared
    
    let waitingHostLabel:UILabel = UILabel()
    let enterTagALongLabel: UILabel = UILabel()
    let confirmButton: UIButton = UIButton()
    let cancelTagAlongLabel: UILabel = UILabel()
    let hostUnavailableLabel: UILabel = UILabel()
    let searchNewTagAlongButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
//    var guestStatus = FirebaseManager.shared.guestStatus {
//        didSet {
//            
//            guard let guestID = store.guestID else { return }
//            
//            if guestStatus[guestID] == true {
//                confirmButton.isHidden = false
//            }
//            else {
//                hostUnavailableLabel.isHidden = false
//                searchNewTagAlongButton.isHidden = false
//            }
//            
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeGuestTagalongStatus()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = phaedraOliveGreen
        setupViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupViews() {
        view.addSubview(waitingHostLabel)
        waitingHostLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        waitingHostLabel.lineBreakMode = .byWordWrapping
        waitingHostLabel.numberOfLines = 0
        waitingHostLabel.text = "We're waiting for your host to approve the Tag Along!"
        waitingHostLabel.textColor = phaedraYellow
        waitingHostLabel.textAlignment = .center
        waitingHostLabel.translatesAutoresizingMaskIntoConstraints = false
        waitingHostLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        waitingHostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        waitingHostLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        view.addSubview(enterTagALongLabel)
        enterTagALongLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        enterTagALongLabel.lineBreakMode = .byWordWrapping
        enterTagALongLabel.numberOfLines = 0
        enterTagALongLabel.text = "Great! Your tag along has been confirmed. Click to chat"
        enterTagALongLabel.textColor = phaedraYellow
        enterTagALongLabel.textAlignment = .center
        enterTagALongLabel.translatesAutoresizingMaskIntoConstraints = false
        enterTagALongLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        enterTagALongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        enterTagALongLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        enterTagALongLabel.isHidden = true
        
        
        view.addSubview(confirmButton)
        confirmButton.backgroundColor = phaedraOrange
        confirmButton.layer.cornerRadius = 5
        confirmButton.setTitle("Start Chatting", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 17.0)
        confirmButton.titleLabel?.textAlignment = .center
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.topAnchor.constraint(equalTo: waitingHostLabel.bottomAnchor, constant: 30).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        confirmButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        confirmButton.addTarget(self, action: #selector(goToTagAlongTabbedView), for: .touchUpInside)
        confirmButton.setTitleColor(phaedraYellow, for: .normal)
        confirmButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        confirmButton.isHidden = true
        
        view.addSubview(activityIndicator)
        activityIndicator.color = phaedraYellow
        activityIndicator.layer.cornerRadius = 4
        activityIndicator.layer.backgroundColor = phaedraOliveGreen.cgColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 40).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
        
        view.addSubview(hostUnavailableLabel)
        hostUnavailableLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        hostUnavailableLabel.lineBreakMode = .byWordWrapping
        hostUnavailableLabel.numberOfLines = 0
        hostUnavailableLabel.text = "Drats! The host is currently unavailable."
        hostUnavailableLabel.textColor = phaedraYellow
        hostUnavailableLabel.textAlignment = .center
        hostUnavailableLabel.translatesAutoresizingMaskIntoConstraints = false
        hostUnavailableLabel.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 100).isActive = true
        hostUnavailableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        hostUnavailableLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        //change this later
        hostUnavailableLabel.isHidden = true
        
        //NOTE: - Cancel Tag Along Label
        view.addSubview(cancelTagAlongLabel)
        cancelTagAlongLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        cancelTagAlongLabel.lineBreakMode = .byWordWrapping
        cancelTagAlongLabel.numberOfLines = 0
        cancelTagAlongLabel.text = "Drats! The host is currently unavailable."
        cancelTagAlongLabel.textColor = phaedraYellow
        cancelTagAlongLabel.textAlignment = .center
        cancelTagAlongLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelTagAlongLabel.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 100).isActive = true
        cancelTagAlongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        cancelTagAlongLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        cancelTagAlongLabel.isHidden = false
        
        view.addSubview(searchNewTagAlongButton)
        searchNewTagAlongButton.backgroundColor = phaedraOrange
        searchNewTagAlongButton.layer.cornerRadius = 5
        searchNewTagAlongButton.setTitle("Get New Tag Along", for: .normal)
        searchNewTagAlongButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 17.0)
        searchNewTagAlongButton.titleLabel?.textAlignment = .center
        searchNewTagAlongButton.translatesAutoresizingMaskIntoConstraints = false
        searchNewTagAlongButton.topAnchor.constraint(equalTo: hostUnavailableLabel.bottomAnchor, constant: 40).isActive = true
        searchNewTagAlongButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchNewTagAlongButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        searchNewTagAlongButton.addTarget(self, action: #selector(searchOtherTagAlongs), for: .touchUpInside)
        searchNewTagAlongButton.setTitleColor(phaedraYellow, for: .normal)
        searchNewTagAlongButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        searchNewTagAlongButton.isHidden = false
        
    }
    
    func goToTagAlongTabbedView() {
        print("User wants to go to chat/tabbed bar controller.")
        let tabVC = TabBarController()
        tabVC.tagAlong = store.selectedTagAlongID!
        self.navigationController?.pushViewController(tabVC, animated: true)
        //self.navigationController?.present(tabVC, animated: true, completion: nil)
    }
    
    func searchOtherTagAlongs() {
        print("User wants to pick a different Tag Along.")
        let tagAlongVC = TagAlongViewController()
        self.navigationController?.present(tagAlongVC, animated: true, completion: nil)
        
    }
    
    func observeGuestTagalongStatus() {
        print("about to observe guest tagalong status")
        
        store.observeGuestTagalongStatus { (snapshot) in
            
            print("starting to observe guest tagalong status")
            
            if let result = snapshot?.value as? Bool {
                
                if result {
                    
                    // TODO: Reveal enter tag along button
                    
                    self.waitingHostLabel.isHidden = true
                    self.enterTagALongLabel.isHidden = false
                    self.confirmButton.isHidden = false
                    
                    guard let tagAlong = self.store.selectedTagAlongID else { print("this has no value");return }
                   FirebaseManager.joinChat(with: tagAlong, completion: {
                        self.goToTagAlongTabbedView()
                   })
                    
                    
                } else {
                    
                    // TODO: Not true, it's FALSE so do something else.
                }
                
            }
            
            if let noResult = snapshot?.value as? String {
                
                if noResult == "none" {
                    
                    // TODO: They've been denied, do something else.
                    self.hostUnavailableLabel.isHidden = false
                    self.cancelTagAlongLabel.isHidden = true
                    self.searchNewTagAlongButton.isHidden = false
                }
                
            }

        
    }
 
}
}
