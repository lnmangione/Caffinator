//
//  ViewController.swift
//  Caffinator
//
//  Created by Luigi Mangione on 3/16/17.
//  Copyright © 2017 AppRoar Studios. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            self.mapView.delegate = self
            self.mapView.mapType = .standard
            self.mapView.showsUserLocation = true
        }
    }
    
    let manager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setting up
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // request permission
        self.manager.requestWhenInUseAuthorization()
        
        // actually start getting location
        self.manager.startUpdatingLocation()
        
        // TODO - set the mapView's initial region
        /*
        let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        */
        
        NetworkManager.load(closure: {(locations) in
            if locations != nil {
                DispatchQueue.main.async {
                    for location in (locations as! [Location]?)! {
                       
                    }
                }
            }
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

