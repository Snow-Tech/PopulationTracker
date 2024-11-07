//
//  PopulationOutput.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public struct PopulationResponse: Codable {
    let data: [USAData]?
    let source: [Source]?
}

public struct USAData: Codable, Identifiable {
    public var id: String { UUID().uuidString }
    
    let idNation, idState: String?
    let nation, state: String?
    let idYear: Int
    let year: String
    let population: Int
    let slugNation, slugState: String?

    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case idState = "ID State"
        case nation = "Nation"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
        case slugState = "Slug State"
    }
}

public struct Source: Codable {
    let measures: [String]
    let annotations: Annotations
    let name: String
}

public struct Annotations: Codable {
    let sourceName, sourceDescription, datasetName, datasetLink: String
    let tableID, topic: String

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
        case datasetName = "dataset_name"
        case datasetLink = "dataset_link"
        case tableID = "table_id"
        case topic
    }
}

public struct ErrorResponse: Decodable {
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}
