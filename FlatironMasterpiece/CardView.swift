//
//  CardView.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/23/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class CardView: UIView {
    class CardView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
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
            
            // Corner Radius
            layer.cornerRadius = 10.0;
        }
    }
}
