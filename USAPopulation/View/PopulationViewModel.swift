//
//  PopulationViewModel.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public enum Segment: String, CaseIterable {
    case nation = "Nation"
    case state = "State"
}

protocol PopulationViewModelProtocol {
    typealias APIResponse = Result<PopulationResponse, RequestError>
    
    var population: [USAData] { get }
    var currentSegment: Segment { get set }
    var requestError: RequestError? { get set }
    
    func fetchPopulation() async
    func populationInfoViewModel(_ data: USAData) -> PopulationInfoViewModel
}

@Observable
final class PopulationViewModel: PopulationViewModelProtocol {
    
    private var populationData: PopulationResponse?
    public var requestError: RequestError?
    public var currentSegment: Segment = .nation
    
    public struct Dependecies {
        let service: USADataServiceProtocol
        
        public init(service: USADataServiceProtocol) {
            self.service = service
        }
    }
    
    public var dependencies: Dependecies
    
    public init(dependencies: Dependecies) {
        self.dependencies = dependencies
    }
    
    public var population: [USAData] {
        return populationData?.data ?? []
    }
    
    public var params: USADataParameters {
        return USADataParameters(drilldowns: currentSegment.rawValue,
                                 measures: Constants.population)
    }
    
    public func populationInfoViewModel(_ data: USAData) -> PopulationInfoViewModel {
        let dependencies = PopulationInfoViewModel.Dependecies(USAData: data,
                                                               segment: currentSegment)
        return PopulationInfoViewModel(dependencies: dependencies)
    }

    public func fetchPopulation() async {
        let result = await dependencies.service.getPopulationData(parameters: params)
        switch result {
        case .success(let results):
            populationData = results
        case .failure(let error):
            requestError = error
        }
    }

    private enum Constants {
        static let population = "Population"
        static let latest = "latest"
    }
}
