//
//  NetworkManager.swift
//  Caffinator
//
//  Created by Mikael Mantis on 3/19/17.
//  Copyright © 2017 AppRoar Studios. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static var locations = [Location]()
    
    static func load(closure: @escaping (_ response: Any?) -> Void) {
        //print ("test")
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask: URLSessionDataTask?
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let url = URL(string: "https://gist.githubusercontent.com/yagil/a58dfb3dbc6116cddf72104012d7e295/raw/fcb62ad63f14fb57c96a57deff7790c848fdb0bb/places.json")
        
        dataTask = defaultSession.dataTask(with: url!, completionHandler: {
            data, response, error in
            if error != nil {
                
                print(error!.localizedDescription)
                closure(nil)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    if let locationsData = data {
                        let locations = Location.dataToLocation(locationsData)
                        closure(locations)
                    } else {
                        closure(nil)
                    }
                    
                }
            } else {
                closure(nil)
            }
            
        })
        
        dataTask?.resume()

    }
    
}
