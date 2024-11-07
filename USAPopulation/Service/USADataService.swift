//
//  USADataService.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public protocol USADataServiceProtocol {
    func getPopulationData(headers: [String: String]?, parameters: USADataParameters) async -> Result<PopulationResponse, RequestError>
}

extension USADataServiceProtocol {
    func getPopulationData(headers: [String: String]? = nil,
                           parameters: USADataParameters) async -> Result<PopulationResponse, RequestError> {
        await getPopulationData(headers: headers, parameters: parameters)
    }
}

public struct USADataService: ServiceProtocol, USADataServiceProtocol {
    public func getPopulationData(headers: [String : String]? = nil,
                                  parameters: USADataParameters) async -> Result<PopulationResponse, RequestError> {
        let request = USADataRequests.PopulationData(headers: headers, parameters: parameters)
        return await sendRequest(request: request, responseModel: PopulationResponse.self)
    }
}
