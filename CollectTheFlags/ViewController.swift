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
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                // Spawn a Flag
                
                if let coord = self.manager.location?.coordinate {
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    let randoLat = (Double(arc4random_uniform(20)) - 10.0) / 10000.0
                    let randoLon = (Double(arc4random_uniform(20)) - 10.0) / 10000.0
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.longitude += randoLon
                    self.mapView.addAnnotation(anno)
                }
            })
            
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 3 {
        let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 75, 75)
        mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = manager.location?.coordinate {
        let region = MKCoordinateRegionMakeWithDistance(coord, 75, 75)
        mapView.setRegion(region, animated: true)
        }
    }
    
}

