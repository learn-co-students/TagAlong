//
//  PracticeViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cuisineCollectionView:UICollectionView!
    let cuisineReuseIdentifier = "Cuisine Cell"
    let cuisineImage:[UIImage] = [UIImage(named: "american")!, UIImage(named:"asian")!]
    let cuisineArray:[String] = ["american", "asian", "italian", "latin", "healthy", "unhealthy" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutCuisineCollectionView()
        print("is running")
        view.backgroundColor = UIColor.purple
    }
    

    func layoutCuisineCollectionView() {
        
        let frame = CGRect.zero
        let flowLayout = UICollectionViewFlowLayout()
        cuisineCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        
        cuisineCollectionView.backgroundColor = UIColor.green
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        view.addSubview(cuisineCollectionView)
        
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        cuisineCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cuisineCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        cuisineCollectionView.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineReuseIdentifier, for: indexPath) as! CuisineCollectionViewCell
        
        cell.imageView.image = cuisineImage[indexPath.item]
        cell.foodLabel.text = cuisineArray[indexPath.item]
        
        // Configure the cell
        
        return cell
    }

}
