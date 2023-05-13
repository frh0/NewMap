//
//  File.swift
//  NewMap
//
//  Created by frh alshaalan on 13/05/2023.
//

import Foundation
import SwiftUI
import MapKit


class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    // Delegate method to handle user location updates
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        parent.centerCoordinate = userLocation.coordinate
        
        // Zoom in on user location
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    // Delegate method to handle pin view for annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Placemark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Add button to annotation view
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    // Delegate method to handle user selecting annotation button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let placemark = view.annotation as! MKPointAnnotation
        
        // Add pin to parent locations array
        parent.locations.append(placemark)
    }
}
