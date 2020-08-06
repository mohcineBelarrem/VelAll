//
//  Station.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 04/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import Foundation
import MapKit
import Contacts


struct Position : Decodable {
    
    let lat : Double
    let lng : Double
}



struct Station : Decodable {
    
    let number : Int
    let contractName : String
    let name : String
    let address : String
    let position : Position
    let banking : Bool
    let bonus : Bool
    let bikeStands : Int
    let availableBikeStands : Int
    let availableBikes : Int
    let status : String
    let lastUpdate : Date
    
}


class MapStation : NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var address : String?
    var availableBikeStands : Int
    var availableBikes : Int
    
    init(station : Station) {
        coordinate = CLLocationCoordinate2D(latitude: station.position.lat, longitude: station.position.lng)
        title = station.name
        subtitle = "🚲 \(station.availableBikes)  🅿️ \(station.availableBikeStands)"
        address = station.address
        availableBikeStands = station.availableBikeStands
        availableBikes = station.availableBikes
    }
    
    var mapItem: MKMapItem? {
        guard let location = address else {
            return nil
        }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate,addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    func markerTintColor(criterium : Int) -> UIColor {
        
        if (0...2).contains(criterium) {
            return .systemRed
        } else if (3...5).contains(criterium) {
            return .systemOrange
        } else {
            return .systemGreen
        }
        
    }
}


class MapStationAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            
            guard let mapStation = newValue as? MapStation else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = mapStation.markerTintColor(criterium: mapStation.availableBikes)
            glyphText = String(mapStation.availableBikes)
            
        }
    }
}
