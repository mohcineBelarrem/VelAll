//
//  NetworkModel.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 05/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case badURL
    case badData
    case badJSON
    case unknown(description : String)
}



struct NetworkModel {
    static let scheme = "https"
    static let baseHost = "api.jcdecaux.com"
    static let contractsPath = "/vls/v1/contracts"
    static let stationsPath = "/vls/v1/stations"
    static func contractNameQueryItem(contractName : String) -> URLQueryItem {
        return URLQueryItem(name: "contract", value: contractName)
    }
    static let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: apiKey)
}
