//
//  Mockable.swift
//  USAPopulationTests
//
//  Created by michael on 07/11/2024.
//

import Foundation
import USAPopulation

protocol MockableServiceProtocol: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension MockableServiceProtocol {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}

final class USADataServiceMock: MockableServiceProtocol, USADataServiceProtocol {
    func getPopulationData(headers: [String : String]?,
                           parameters: USAPopulation.USADataParameters) async -> Result<PopulationResponse, USAPopulation.RequestError> {
        
        let filename: String
        
        if parameters.drilldowns == "Nation" {
            if parameters.year == "" {
                return .failure(.invalidURL)
            } else if parameters.year == "latest" || !(parameters.year?.isEmpty ?? false) {
                filename = "nation_population_latest_response"
            } else {
                filename = "nation_population_response"
            }
        } else if parameters.drilldowns == "State" {
            if parameters.year == "" {
                return .failure(.invalidURL)
            } else if parameters.year == "latest" || !(parameters.year?.isEmpty ?? false) {
                filename = "state_population_latest_response"
            } else {
                filename = "state_population_response"
            }
        } else {
            return .failure(.invalidURL)
        }
        
        return .success(loadJSON(filename: filename, type: PopulationResponse.self))
    }
}
