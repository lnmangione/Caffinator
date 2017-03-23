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

    @IBOutlet weak var mapViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoSegment: UISegmentedControl!
    var selectedLocation: Location?
    var mapConstraint1 : NSLayoutConstraint!
    var mapConstraint2 : NSLayoutConstraint!
    
    @IBOutlet var superView: UIView!
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            self.mapView.delegate = self
            self.mapView.mapType = .standard
            self.mapView.showsUserLocation = true
        }
    }
    
    @IBAction func toggleInfo(_ sender: Any) {
        let segment = (sender as! UISegmentedControl)
        if segment.selectedSegmentIndex == 0{
            showDetails()
        }
        if segment.selectedSegmentIndex == 1{
            showMenu()
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
        
        
        mapConstraint1 = NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height , multiplier: 0.5, constant: 0.0)
        mapConstraint2 = NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height , multiplier: 1.0, constant: 0.0)
        mapConstraint1.isActive = true
        mapConstraint2.isActive = false
        mapViewHeight.isActive = false
       
      
    }
    
   
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            infoPane(shouldHide: true)
            //mapViewHeight.constant = 1
            mapConstraint1.isActive = false
            mapConstraint2.isActive = true
            print (mapConstraint2.isActive)
            self.view.layoutIfNeeded()
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            infoPane(shouldHide: false)
            //mapViewHeight.constant = 0.5
            mapConstraint1.isActive = true
            mapConstraint2.isActive = false
            print (mapConstraint2.isActive)
            self.view.layoutIfNeeded()
        }
    }
    
    func infoPane(shouldHide: Bool){
        infoSegment.isHidden = shouldHide
        infoLabel.isHidden = shouldHide
        locationLabel.isHidden = shouldHide
    }

    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView){
        let annotation = view.annotation
        if let location = annotation as? Location {
            selectedLocation = location
            locationLabel.text = selectedLocation?.name
            if infoSegment.selectedSegmentIndex == 0{
                showDetails()
            }
            if infoSegment.selectedSegmentIndex == 1{
                showMenu()
            }
        }
    }
    
    func showMenu(){
        if (selectedLocation != nil){
            infoLabel.text = "Menu:\n" + (selectedLocation?.menu)!
        }
    }
    
    func showDetails(){
        if (selectedLocation != nil){
            var details = ""
            details += "Address: " + (selectedLocation?.address)! + "\n"
            details += "Phone: " + (selectedLocation?.phone)! + "\n"
            details += "Hours: " + (selectedLocation?.hours)!
            infoLabel.text = details
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
