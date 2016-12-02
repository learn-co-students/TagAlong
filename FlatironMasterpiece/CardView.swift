//
//  CardView.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/23/16.
//  Copyright © 2016 Elias Miller. All rights reserved.

//OK SO NEXT: add the image view constrainted to top of name field, center x axis.  Other constraints to bottom of name etc

import UIKit

class CardView: UIView {
    
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

//        var dumblabel = UILabel(frame: CGRect(x: self.bounds.width * 0.28, y: self.bounds.height * 0.43, width: self.bounds.width * 0.5, height: self.bounds.width * 0.15))
//        self.addSubview(dumblabel)
//
//
//        
//        dumblabel.text = "LOOGIT THEM CARRRRRRRRRDS"
// //       dumblabel.translatesAutoresizingMaskIntoConstraints = false
//        dumblabel.backgroundColor = UIColor.red
//        dumblabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dumblabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        dumblabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        dumblabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
//
        
        var restImageView = UIImageView()
        var restNameLabel = UILabel()
        var restCuisineLabel = UILabel()
        var restCostLabel = UILabel()
        var restDistanceLabel = UILabel()
        var restHoursLabel = UILabel()
//
        restImageView = UIImageView(frame: CGRect(x: self.bounds.width * -0.0001, y: self.bounds.height * -0.10, width: self.bounds.width, height: self.bounds.height * 0.50))
//      restImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5));
        restImageView.image = UIImage(named: testArray1[0])
        self.addSubview(restImageView)
        restImageView.backgroundColor = UIColor.yellow
//        restImageView.translatesAutoresizingMaskIntoConstraints = false
//        restImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        restImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        restImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
//        restImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        

        //       restImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
 //       restImageView.bottomAnchor.constraint(equalTo: restNameLabel.topAnchor, constant: 5).isActive = true

//
       
        self.addSubview(restCuisineLabel)
        self.addSubview(restCostLabel)
        self.addSubview(restDistanceLabel)
        self.addSubview(restHoursLabel)
        
        let frame = CGRect(x: self.bounds.width * 0.27, y: self.bounds.height * 0.43, width: self.bounds.width * 0.5, height: self.bounds.width * 0.05)
        let newFrame = CGRect(x: 350, y: 350, width: 200, height: 200)
        
        restNameLabel = UILabel(frame: frame)
        
        restNameLabel.backgroundColor = UIColor.yellow
        
         self.addSubview(restNameLabel)
        //        restNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        restCuisineLabel.translatesAutoresizingMaskIntoConstraints = false
//        restHoursLabel.translatesAutoresizingMaskIntoConstraints = false
//        restCostLabel.translatesAutoresizingMaskIntoConstraints = false
//        restDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        restNameLabel.text = testArray1[1]
//        restCuisineLabel.text = testArray1[2]
//        restCostLabel.text = testArray1[3]
//        restDistanceLabel.text = testArray1[4]
//        restHoursLabel.text = testArray1[5]
//        
//        restNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        restNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        restNameLabel.backgroundColor = UIColor.yellow
//        restNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40).isActive = true
//        restNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//
//        
//        restCuisineLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        restCuisineLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        restCuisineLabel.backgroundColor = UIColor.yellow
//        restCuisineLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +60).isActive = true
//        restCuisineLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        
//        restCostLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        restCostLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        restCostLabel.backgroundColor = UIColor.yellow
//        restCostLabel.topAnchor.constraint(equalTo: restNameLabel.bottomAnchor, constant: 20).isActive = true
//        restCostLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40).isActive = true
//
//        restDistanceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        restDistanceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        restDistanceLabel.backgroundColor = UIColor.yellow
//        restDistanceLabel.topAnchor.constraint(equalTo: restCuisineLabel.bottomAnchor, constant: 20).isActive = true
//        restDistanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40).isActive = true
//        
//        
//        var dumblabel = UILabel(frame: CGRect(x: self.bounds.width * 0.25, y: self.bounds.height * 0.43, width: self.bounds.width * 0.5, height: self.bounds.width * 0.15))
//        
//        restHoursLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.45, y: self.bounds.height * 0.25, width:))
//        restHoursLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        restHoursLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        restHoursLabel.backgroundColor = UIColor.yellow
//        restHoursLabel.topAnchor.constraint(equalTo: restCostLabel.bottomAnchor, constant: 20).isActive = true
//        restHoursLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        restHoursLabel = UILabel(frame: CGRect(x: self.bounds.width * 0.45, y: self.bounds.height * 0.25, width: self.bounds.width * 0.5, height: self.bounds.width * 0.15))
//            restHoursLabel.backgroundColor = UIColor.red
//            restHoursLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//            restHoursLabel.centerYAnchor.constraint(equalTo: dumblabel.bottomAnchor).isActive = true
//            restHoursLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            restHoursLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
            //
//        
        
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
}
