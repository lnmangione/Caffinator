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
    }
    
    // TODO - properly resize views upon rotation
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            infoPane(shouldHide: true)
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            infoPane(shouldHide: false)
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
