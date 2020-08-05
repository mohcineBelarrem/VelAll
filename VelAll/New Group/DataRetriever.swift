//
//  DataRetriever.swift
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



struct DataRetriever {
    
    static func fetchContracts(completionHandler: @escaping (Result<[Contract], NetworkError>) -> Void) {
        
        guard let url = URL(string: Model.baseURL) else {
            
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
}

        
    
    

