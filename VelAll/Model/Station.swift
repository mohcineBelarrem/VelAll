//
//  Station.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 04/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import Foundation


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


