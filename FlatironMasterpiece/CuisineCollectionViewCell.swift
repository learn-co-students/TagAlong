//
//  CuisineCollectionViewCell.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/18/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func toggledSelectedState() {
        if isHighlighted == true {

            self.alpha = 1.0
            self.layer.borderColor = phaedraOrange.cgColor
            self.layer.borderWidth = 4
            self.layer.cornerRadius = 43
        } else if !isHighlighted {
            self.layer.borderWidth = 0
//            self.alpha = 0.5
//            self.layer.borderColor = phaedraOrange.cgColor
        }
    }
}

class CuisineCollectionViewCell: UICollectionViewCell {

    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
    let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
    let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
    let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
    let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)

    var imageView: UIImageView!

    var isHighighted: Bool = false

    var foodLabel: UILabel = {
        let label = UILabel()
        label.text = "Cuisine Type"
        label.font = UIFont(name: "OpenSans-Bold", size: 15.0)
        label.textAlignment = .center
        label.textColor = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {

        //backgroundColor = UIColor.orange

        //imageView
        imageView = UIImageView()
        self.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 43
//        imageView.layer.borderColor = phaedraOrange.cgColor
//        imageView.layer.borderWidth = 2
//        imageView.layer.backgroundColor = phaedraLightGreen.cgColor
//        imageView.alpha = 0.5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        addSubview(foodLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":foodLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":foodLabel]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
