//
//  Contract.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 04/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import Foundation


struct Contract : Decodable {
    
    enum CodingKeys : String,CodingKey {
        case name,cities
        case commercialName = "commercial_name"
        case countryCode = "country_code"
    }

    let name : String
    let commercialName : String
    let cities : [String]
    let countryCode : String
    
    
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "No Name"
        self.commercialName = try container.decodeIfPresent(String.self, forKey: .commercialName) ?? "No Commercial Name"
        self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode) ?? "No Country"
        self.cities = try container.decodeIfPresent([String].self, forKey: .cities) ?? [String]()
    }
    
    
    var description : String {

        return "Name : \(name)\n" +
                "Commercial Name : \(commercialName)\n" +
                "Country Code : \(countryCode)\n" +
                "cities : \(cities)\n"
    }

}
