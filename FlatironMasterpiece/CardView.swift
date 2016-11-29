//
//  CardView.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/23/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
//
//import UIKit
//
//class CardView: UIView {
//    class CardView: UIView {
//        
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            setup()
//        }
//        
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//            setup()
//        }
//        
//        func setup() {
//            // Shadow
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 0.25
//            layer.shadowOffset = CGSize(width: 0, height: 1.5)
//            layer.shadowRadius = 4.0
//            layer.shouldRasterize = true
//            layer.rasterizationScale = UIScreen.main.scale
//            //do constraints here
//            
//            
//            
//            
//            
//            // Corner Radius
//            layer.cornerRadius = 10.0;
//        }
//    }
//}
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        var dumblabel = UILabel()
        self.addSubview(dumblabel)
        dumblabel.text = "AY YO WHADDUP"
        dumblabel.translatesAutoresizingMaskIntoConstraints = false
        dumblabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dumblabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dumblabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dumblabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        
        
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
}
