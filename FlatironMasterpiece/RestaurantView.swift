//
//  RestaurantView.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import MapKit
protocol RestaurantViewDelegate: class {
    func sendToTagAlongConfirmation()
    func sendToDeckView()
}

class RestaurantView: UIView, MKMapViewDelegate {
    
    weak var delegate: RestaurantViewDelegate?

    @IBOutlet var contentView: UIView!
    
    weak var restaurant: Restaurant? {
        didSet {
            setupRestaurant()
            setupMap()
        }
    }
    
    var alreadyZoomedIn = false

    
    
    @IBOutlet weak var restMap: MKMapView!
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
        restMap.delegate = self
    }
    
    func setupMap() {
        print("\n")
        print("\n")

        
        guard let latitude = restaurant?.latitude,
            let longitude = restaurant?.longitude else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        print(latitude)
        print(longitude)
        
        restMap.isZoomEnabled = true
//        
//       // restMap.setCenter(coordinate, animated: true)
//       let span = MKCoordinateSpan(latitudeDelta: latitude, longitudeDelta: longitude)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        restMap.setRegion(region, animated: true)
        
        restMap.setCenter(coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        restMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = restaurant?.name
        restMap.addAnnotation(annotation)
       
        // restMap.centerCoordinate = coordinate
        
        print("\n")
        
        print("We've setup the map!")
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        print("user selected map annotation")
        let placemark = MKPlacemark(coordinate: (view.annotation?.coordinate)!, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeWalking, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        mapItem.openInMaps(launchOptions: launchOptions as? [String : Any])
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("\n")
        print("Map view did Update!!")
        if(!alreadyZoomedIn) {
            self.zoomInOnCurrentLocation()
            alreadyZoomedIn = true
        }
    }
    
    func zoomInOnCurrentLocation() {
        
        let userCoordinate = restMap.userLocation.coordinate
        let longitudeDeltaDegrees : CLLocationDegrees = 0.03
        let latitudeDeltaDegrees : CLLocationDegrees = 0.03
        let userSpan = MKCoordinateSpanMake(latitudeDeltaDegrees, longitudeDeltaDegrees)
        let userRegion = MKCoordinateRegionMake(userCoordinate, userSpan)
        
        restMap!.setRegion(userRegion, animated: true)
    }
    
    func setupRestaurant() {
        selectedRestaurantLabel.text = restaurant?.name
        selectedRestaurantAddressLabel.text = restaurant?.address
        if let unwrappedPriceLevel = restaurant?.priceLevel {
            let emojiString = changePriceToEmoji(level: unwrappedPriceLevel)
            restaurantPricingLabel.text = emojiString
        }
    }
    
    func setup(cuisine: String) {
         selectedCuisineLabel.text = cuisine
    }
 
    
}

extension RestaurantView {
    func changePriceToEmoji(level:Int)->String {
        switch level {
        case 0:
            return "💰"
        case 1:
            return "💰💰"
        case 2:
            return "💰💰💰"
        case 3:
            return "💰💰💰💰"
        default:
            return "💰💰"
        }
    }
}
