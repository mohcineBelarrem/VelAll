//
//  DataRetriever.swift
//  VelAll
//
//  Created by Mohcine BELARREM on 05/08/2020.
//  Copyright © 2020 Mohcine BELARREM. All rights reserved.
//

import Foundation


struct DataRetriever {
    
    static func fetchContracts(completionHandler: @escaping (Result<[Contract], NetworkError>) -> Void) {
        
        var components = URLComponents()
        
        components.scheme = NetworkModel.scheme
        components.host = NetworkModel.baseHost
        components.path = NetworkModel.contractsPath
        components.queryItems = [NetworkModel.apiKeyQueryItem]
        
        guard let url = components.url else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(.badData))
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode([Contract].self, from: data) {
                completionHandler(.success(decodedResponse))
                return
            }
            
            completionHandler(.failure(.unknown(description: error?.localizedDescription ?? "Unknown Error")))
            
        }.resume()
        
    }
    
    
    static func fetchStations(for contract : String, completionHandler: @escaping (Result<[Station], NetworkError>) -> Void) {
        
        var components = URLComponents()
        
        components.scheme = NetworkModel.scheme
        components.host = NetworkModel.baseHost
        components.path = NetworkModel.stationsPath
        components.queryItems = [NetworkModel.contractNameQueryItem(contractName: contract),NetworkModel.apiKeyQueryItem]
        
        guard let url = components.url else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let decodedResponse = try? decoder.decode([Station].self, from: data) {
                completionHandler(.success(decodedResponse))
                return
            }
            
            completionHandler(.failure(.unknown(description: error?.localizedDescription ?? "Unknown Error")))
            
        }.resume()
        
    }
}

        
    
    

