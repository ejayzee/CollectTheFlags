//
//  ViewController.swift
//  CollectTheFlags
//
//  Created by EMMANUEL J ZAFRA on 11/23/16.
//  Copyright © 2016 EMMANUEL J ZAFRA. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to go!")
            mapView.showsUserLocation = true
            
            manager.startUpdatingLocation()
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 1 {
        let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 30, 30)
        mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = manager.location?.coordinate {
        let region = MKCoordinateRegionMakeWithDistance(coord, 30, 30)
        mapView.setRegion(region, animated: true)
        }
    }
    
}

