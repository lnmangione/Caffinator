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
        
        // detect rotation changes
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        NetworkManager.load(closure: {(locations) in
            if locations != nil {
                DispatchQueue.main.async {
                    for location in (locations as! [Location]?)! {
                       
                    }
                }
            }
        })
        
        
        
    }
    
    // TODO - properly resize views upon rotation
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            
        }
    }
    
    // TODO - complete function body
    func populateMap(){
        // completion handler to be called after data is loaded
        // if data has successfully loaded locations, add each annotation
        // to the mapView
    }
    
    // TODO - complete function body
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl){
        let annotation = view.annotation
        if let location = annotation as? Location {
            // populate views with location information
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

