//
//  RestaurantView.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class RestaurantView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var selectedCuisineLabel: UILabel!
    @IBOutlet weak var selectedRestaurantLabel: UILabel!
    @IBOutlet weak var selectedRestaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantPricingLabel: UILabel!
    
    @IBAction func tagAlongSwitch(_ sender: UISwitch) {
        //TODO: - add code for what to do when the user selects the "tag along" option
        print("The user wants to tag along.")
    }
    
    @IBAction func preferencesButtonTapped(_ sender: UIButton) {
        //TODO: - add code that will take the user to their preferences page
        print("The user wants to see their preferences.")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("SelectedRestaurant", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
 
    

}
