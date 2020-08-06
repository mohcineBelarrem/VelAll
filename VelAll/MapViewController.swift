//
//  MapViewController.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 05/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class MapViewController: UIViewController {
    
    public var contractName : String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    
   override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = contractName
        
        mapView.delegate = self
        
        mapView.register(MapStationAnnotationView.self, forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        DataRetriever.fetchStations(for: contractName) {result in
            
            switch result {
            
            case .success(let stationsList):
                
                for station  in stationsList {
                    let mapStation = MapStation(station: station)
                    self.mapView.addAnnotation(mapStation)
                }
                
                
                
                DispatchQueue.main.async {
                    
                    guard let firstStation = stationsList.first else { return }
                    
                    
                    let firstStationLocation = CLLocation(latitude: firstStation.position.lat, longitude: firstStation.position.lng)
                    let region = MKCoordinateRegion(center: firstStationLocation.coordinate,latitudinalMeters: 50000,longitudinalMeters: 60000)
                    self.mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region),animated: true)
                    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
                    self.mapView.setCameraZoomRange(zoomRange, animated: true)
                    
                    self.mapView.centerToLocation(firstStationLocation)
                }
                
                
            case.failure(_):
                //TODO: Show some feedback
                print("Error")
            }
                
            }
            
        }
    
}


private extension MKMapView {
  func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 3000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}




extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
        guard let mapStation = view.annotation as? MapStation else {
            return
        }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapStation.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
