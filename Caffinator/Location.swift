//
//  Location.swift
//  Caffinator
//
//  Created by Luigi Mangione on 3/19/17.
//  Copyright © 2017 AppRoar Studios. All rights reserved.
//

import UIKit
import MapKit

class Location: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var address: String
    var phone: String
    var hours: String
    var menu: String
    
    init(coord: CLLocationCoordinate2D, name: String, address: String, phone: String, hours: String, menu: String){
        self.coordinate = coord
        self.name = name
        self.address = address
        self.phone = phone
        self.hours = hours
        self.menu = menu
    }
}
