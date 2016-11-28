//
//  SearchOrTagAlongViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/26/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SearchOrTagAlongViewController: UIViewController {
    
    let searchLabel:UILabel = UILabel()
    let searchButton: UIButton = UIButton()
    let tagAlongLabel: UILabel = UILabel()
    let tagAlongButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraOliveGreen
        setupViews()
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
        searchLabel.font = UIFont(name: "AvenirNext-Bold", size: 40.0)
        searchLabel.lineBreakMode = .byWordWrapping
        searchLabel.numberOfLines = 0
        searchLabel.text = "Find a restaurant"
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
        searchButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        searchButton.titleLabel?.textAlignment = .center
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        searchButton.addTarget(self, action: #selector(searchForRestaurant), for: .touchUpInside)
        searchButton.setTitleColor(phaedraYellow, for: .normal)
        searchButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        view.addSubview(tagAlongLabel)
        tagAlongLabel.font = UIFont(name: "AvenirNext-Bold", size: 40.0)
        tagAlongLabel.lineBreakMode = .byWordWrapping
        tagAlongLabel.numberOfLines = 0
        tagAlongLabel.text = "Tag Along"
        tagAlongLabel.textColor = phaedraYellow
        tagAlongLabel.textAlignment = .center
        tagAlongLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        tagAlongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        view.addSubview(tagAlongButton)
        tagAlongButton.backgroundColor = phaedraLightGreen
        tagAlongButton.layer.cornerRadius = 5
        tagAlongButton.setTitle("Search", for: .normal)
        tagAlongButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        tagAlongButton.titleLabel?.textAlignment = .center
        tagAlongButton.translatesAutoresizingMaskIntoConstraints = false
        tagAlongButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 135).isActive = true
        tagAlongButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagAlongButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        tagAlongButton.addTarget(self, action: #selector(addToTagAlong), for: .touchUpInside)
        tagAlongButton.setTitleColor(phaedraOrange, for: .normal)
        tagAlongButton.setTitleColor(phaedraDarkGreen, for: .highlighted)
    }
    
    //TODO: - write code that searches for a restaurant based on the user's location
    func searchForRestaurant() {
        print("User wants to search for a restaurant.")
        self.searchLabel.fadeOut(duration: 0.3, delay: 0.0) { (true) in
            self.searchButton.fadeOut(duration: 0.2, delay: 0.3, completion: { (true) in
                //
            })
        }
    }
    
    //TODO: - write code that adds user to the tag along tableview
    func addToTagAlong() {
        print("User wants to tag along with another user.")
        self.tagAlongLabel.fadeOut(duration: 0.3, delay: 0.0) { (true) in
            self.tagAlongButton.fadeOut(duration: 0.2, delay: 0.3, completion: { (true) in
                //
            })
        }
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

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
