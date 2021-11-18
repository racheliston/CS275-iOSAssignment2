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
    
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        // Declare variables for POI label and switch
        let poiLabel = UILabel()
        let poiSwitch = UISwitch()
        // Declare variable for Find Me button
        let findMe = UIButton()
        // Change background, text, and border color for Find Me button
        findMe.backgroundColor = UIColor.white
        findMe.setTitleColor(UIColor.black, for: .normal)
        findMe.layer.borderWidth = 1
        findMe.layer.borderColor = UIColor.black.cgColor
        // set corner rounding for find me button to be 2 points
        findMe.layer.cornerRadius = 2
        
        
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
        
        // Assign title to Find Me button
        findMe.setTitle("Find Me", for: .normal)
        findMe.translatesAutoresizingMaskIntoConstraints = false
        findMe.addTarget(self, action: #selector(findMeButton), for: .touchUpInside)
        // Add Find Me button to view
        view.addSubview(findMe)
        
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
        
        // Constraints for Find me button
        let findMeLabel1 = findMe.topAnchor.constraint(equalTo: poiLabel.bottomAnchor, constant: 8)
        let findMeLabel2 = findMe.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let fmButtonWidthConstraint = findMe.widthAnchor.constraint(
              equalToConstant: findMe.titleLabel!.intrinsicContentSize.width + 2.0 * 3)
        
        // Activate all constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        poiLabel1.isActive = true
        poiLabel2.isActive = true
        poiSwitch1.isActive = true
        poiSwitch2.isActive = true
        poiSwitch3.isActive = true
        findMeLabel1.isActive = true
        findMeLabel2.isActive = true
        fmButtonWidthConstraint.isActive = true
        
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
    
    // interesting location of choice (Eiffel Tower)
    let eiffelTower = CLLocation(latitude: 48.8584, longitude: 2.2945)
    
    // Function for "Find Me" to zoom to interesting location
    @objc func findMeButton() {
        centerMapOnLocation(location: eiffelTower)
    }
    
    // Helper function to zoom in on location when Find Me button is pressed
    let regionRadius: CLLocationDistance = 200
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
}
