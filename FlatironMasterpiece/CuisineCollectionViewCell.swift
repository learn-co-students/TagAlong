//
//  CuisineCollectionViewCell.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/18/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class CuisineCollectionViewCell: UICollectionViewCell {
    
    var foodLabel: UILabel = {
        let label = UILabel()
        label.text = "Cuisine Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = UIColor.orange
        addSubview(foodLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":foodLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":foodLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
