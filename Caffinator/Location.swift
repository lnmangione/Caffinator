//
//  Location.swift
//  Caffinator
//
//  Created by Luigi Mangione on 3/19/17.
//  Copyright © 2017 AppRoar Studios. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Location: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var address: String
    var phone: String
    var hours: String
    var menu: String
    
    init(name: String, address: String, phone: String, hours: String, menu: String){
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        self.name = name
        self.address = address
        self.phone = phone
        self.hours = hours
        self.menu = menu
    }
    
    static func dataToLocation(_ data : Data?) -> [Location]? {
        // Inspired by: https://www.raywenderlich.com/110458/nsurlsession-tutorial-getting-started
        var locationResults = [Location]()
        do {
            if let data = data {
                if let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                    if let array: AnyObject = response["locations"] {
                       for locDictonary in array as! [AnyObject] {
                        if let locDictonary = locDictonary as? [String: AnyObject], let address = locDictonary["address"] as? String {
                            // Parse the search result
                            let name = locDictonary["name"] as? String
                            let phone = locDictonary["phone"] as? String
                            locationResults.append(Location(name: name!, address: address, phone: phone!, hours: "", menu: ""))
                        } else {
                            print("Not a dictionary")
                        }

                        }
                    }
                    //print (locationResults)
                    return locationResults
                }
            }
        } catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        return nil
    }
    
    func addressToCoord(_ address: String?) -> Void {
        let coder = CLGeocoder()
        coder.geocodeAddressString(address!, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) in
                self.coordinate = (placemarks![0].location?.coordinate)!
            })
        
    }
    

}
