//
//  MapViewController.swift
//  iOSAssignment2
//
//  Created by Rachel Liston on 11/17/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    // Declare variables for POI label and switch
    let poiLabel = UILabel()
    let poiSwitch = UISwitch()
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl
                = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Assign text to POI label
        poiLabel.text = "Points of Interest"
        poiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add POI label to view
        view.addSubview(poiLabel)
        
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        poiSwitch.isOn = false
        poiSwitch.addTarget(self, action: #selector(poiDisplay(_:)), for: .valueChanged)
                
        // Add POI switch to view
        view.addSubview(poiSwitch)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // Constraints for POI label
        let poiLabel1 = poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiLabel2 = poiLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        
        // Constraints for POI switch
        let poiSwitch1 = poiSwitch.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let poiSwitch2 = poiSwitch.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor, constant: 4)
        let poiSwitch3 = poiSwitch.centerYAnchor.constraint(equalTo: poiLabel.centerYAnchor)
        
        // Activate all constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        poiLabel1.isActive = true
        poiLabel2.isActive = true
        poiSwitch1.isActive = true
        poiSwitch2.isActive = true
        poiSwitch3.isActive = true
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    // Function to control POI on map when switch is on or off
    @IBAction func poiDisplay(_ poiSwitch: UISwitch) {
        if (poiSwitch.isOn) {
            mapView.pointOfInterestFilter = MKPointOfInterestFilter.includingAll
        } else {
            mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
}
