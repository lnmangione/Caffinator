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
    
    @IBOutlet weak var infoView: UIView!
    
    @IBAction func toggleInfo(_ sender: Any) {
        let segment = (sender as! UISegmentedControl)
        if segment.selectedSegmentIndex == 0{
            NotificationCenter.default.post(name: Notification.Name("ShowDetails"), object: nil)
        }
        if segment.selectedSegmentIndex == 1{
            NotificationCenter.default.post(name: Notification.Name("ShowMenu"), object: nil)
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
        
        // set the mapView's initial region
        let walnutStreet = CLLocationCoordinate2D(latitude: 39.955333, longitude: -75.197939)
        let region = MKCoordinateRegion(center: walnutStreet, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        self.mapView.setRegion(region, animated: true)
        
        // detect rotation changes
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // add map pins to map
        NetworkManager.load(closure: {(locations) in
            if locations != nil {
                NetworkManager.locations = locations as! [Location]
                for location in NetworkManager.locations {
                    location.addressToCoord()
                    self.mapView.addAnnotation(location)
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

