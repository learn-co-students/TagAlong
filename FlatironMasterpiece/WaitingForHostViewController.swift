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

    var guestStatus: [String: Bool] {
        didSet {
            if guestStatus[store.guestID] == true {
                // Show text
            }
            else {
                // Show text
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        observeHostTagalong()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = phaedraOliveGreen
        setupViews()
    }

    let waitingHostLabel:UILabel = UILabel()
    let confirmButton: UIButton = UIButton()
    let hostUnavailableLabel: UILabel = UILabel()
    let searchNewTagAlongButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

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

        view.addSubview(confirmButton)
        confirmButton.backgroundColor = phaedraOrange
        confirmButton.layer.cornerRadius = 5
        confirmButton.setTitle("Search", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 17.0)
        confirmButton.titleLabel?.textAlignment = .center
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.topAnchor.constraint(equalTo: waitingHostLabel.bottomAnchor, constant: 30).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        confirmButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
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
        hostUnavailableLabel.isHidden = true

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
        searchNewTagAlongButton.isHidden = true
    }

    func goToTagAlongTabbedView() {
        print("User wants to go to chat/tabbed bar controller.")
        let tabVC = TabBarController()
        self.navigationController?.present(tabVC, animated: true, completion: nil)
    }

    func searchOtherTagAlongs() {
        print("User wants to pick a different Tag Along.")
        let tagAlongVC = TagAlongViewController()
        self.navigationController?.present(tagAlongVC, animated: true, completion: nil)

}
    func observeHostTagalong() {

        FirebaseManager.shared.observeGuestTagalongStatus { (snapshot) in

            if snapshot?.value == true {

                //TODO:- Change text on the view

            }

        }
        }



}
