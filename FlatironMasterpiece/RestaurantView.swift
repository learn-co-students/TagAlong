//
//  RestaurantView.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

protocol RestaurantViewDelegate: class {
    func sendToTagAlongConfirmation()
    func sendToDeckView()
}

class RestaurantView: UIView{
    
    weak var delegate: RestaurantViewDelegate?

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var selectedCuisineLabel: UILabel!
    @IBOutlet weak var selectedRestaurantLabel: UILabel!
    @IBOutlet weak var selectedRestaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantPricingLabel: UILabel!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        delegate?.sendToDeckView()
    }
    
    @IBAction func hostTagAlongTapped(_ sender: UIButton) {
        delegate?.sendToTagAlongConfirmation()
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
