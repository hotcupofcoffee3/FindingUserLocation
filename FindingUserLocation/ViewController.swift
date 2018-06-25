//
//  ViewController.swift
//  FindingUserLocation
//
//  Created by Adam Moore on 4/11/18.
//  Copyright © 2018 Adam Moore. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // In the main part of the app, under "Build Phase", then "Link Binary with Libraries", then "CoreLocation.framework" was added.
    // Two Info.plist Privacy things added for requesting and using location services
    
    // Generally create a location manager variable at the beginning
    let locationManager = CLLocationManager()
    
    
    
    
    // Point on the map in the center
    // DO NOT SET VIEW CONTROLLER AS DELEGATE!
    @IBOutlet weak var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Setting view controller as delegate
        locationManager.delegate = self
        
        
        // Specificity of location. Multiple options, such as 10 meters, kilometer, etc.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        // Pop up to request
        locationManager.requestWhenInUseAuthorization()
        
        
        // Starts updating the location
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function called as part of the "StartUpdatingLocation" function.
    // The main location is returned as "locations" internal parameter as [CLLocation]
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        // First entry in locations set to "userLocation"
        let userLocation: CLLocation = locations[locations.count - 1]
        
        
        
        //********** Point on map in the center
        
        // Physical location coordinates
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // How close zoomed in
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        // Region plotted on map based on the zoom (span) and the location (coordinates)
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Sets place actually on map
        self.map.setRegion(region, animated: true)
        
    }

}

