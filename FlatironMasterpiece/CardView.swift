//
//  CardView.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/23/16.
//  Copyright © 2016 Elias Miller. All rights reserved.

//OK SO NEXT: add the image view constrainted to top of name field, center x axis.  Other constraints to bottom of name etc

import UIKit

class CardView: UIView {
    
    var restStore = RestaurantDataStore.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Shadow
        //  self.translatesAutoresizingMaskIntoConstraints = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        var restImageView = UIImageView()
        var restNameLabel = UILabel()
        var restCuisineLabel = UILabel()
        var restCostLabel = UILabel()
        var restDistanceLabel = UILabel()
        var restHoursLabel = UILabel()
        
        //
        // (x: self.bounds.width * -0.0001, y: self.bounds.height * -0.10, width: self.bounds.width, height: self.bounds.height * 0.50))
        
        restImageView = UIImageView(frame: CGRect(x: self.bounds.width * -0.0001, y: self.bounds.height * -0.10, width: self.bounds.width, height: self.bounds.height * 0.66))
        //      restImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5));
        restImageView.image = UIImage(named: testArray1[0])
        self.addSubview(restImageView)
        restImageView.backgroundColor = UIColor.yellow


        restNameLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.43, width: self.bounds.width * 0.5, height: self.bounds.width * 0.08))
        restNameLabel.backgroundColor = UIColor.yellow
        
        restNameLabel.text = restStore.restaurantsArray[0].name
        restNameLabel.textAlignment = .center
        self.addSubview(restNameLabel)

        restCuisineLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.50, width: self.bounds.width * 0.5, height: self.bounds.width * 0.08))
        restCuisineLabel.backgroundColor = UIColor.yellow
        restCuisineLabel.text = "--Cuisine name--"
        restCuisineLabel.textAlignment = .center
        self.addSubview(restCuisineLabel)
        
        restCostLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.57, width: self.bounds.width * 0.5, height: self.bounds.width * 0.08))
        restCostLabel.backgroundColor = UIColor.yellow
        guard let unwrappedRestCost = restStore.restaurantsArray[0].priceLevel else { return }
        let costEmoji = convertPriceToEMOJI(priceLevel: unwrappedRestCost)
        restCostLabel.text = costEmoji
        restCostLabel.textAlignment = .center
        self.addSubview(restCostLabel)
       
        restDistanceLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.64, width: self.bounds.width * 0.5, height: self.bounds.width * 0.08))
        restDistanceLabel.backgroundColor = UIColor.yellow
        restDistanceLabel.text = "0.5 mi"
        restDistanceLabel.textAlignment = .center
        self.addSubview(restDistanceLabel)

        restHoursLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.78, width: self.bounds.width * 0.5, height: self.bounds.width * 0.08))

        restHoursLabel.backgroundColor = UIColor.yellow
        let hoursString = convertHoursToString(isopen: restStore.restaurantsArray[0].openNow)
        restHoursLabel.text = hoursString
        restHoursLabel.textAlignment = .center
        self.addSubview(restHoursLabel)
        
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
    
    func convertPriceToEMOJI(priceLevel:Int)->String {
        var priceEmoji = ""
        switch priceLevel {
            case 1:
            priceEmoji = "💰"
        case 2:
            priceEmoji = "💰💰"
        case 3:
            priceEmoji = "💰💰💰"
        case 4:
            priceEmoji = "💰💰💰💰"
        default:
            break
        }
        return priceEmoji
    }
    
    func convertHoursToString(isopen:Bool)-> String {
        switch isopen {
        case false:
            return "Closed Now"
        case true:
            return "Open Now"
        }
    }
    
}
